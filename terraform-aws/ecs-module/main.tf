module "aws_module" {
  source = "../aws-base-module"
}

resource "aws_ecs_cluster" "cluster" {
  name = "my-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                = "aws-task"
  container_definitions = jsonencode([
    {
      name : "mongo-task",
      # image : aws_ecr_repository.repository["aws_mongo"].repository_url,
      // mongo url below
      image : "${module.aws_module.aws_ecr_url}/${element(module.aws_module.repository_list, 0)}:latest",
      essential : true,
      portMappings : [
        {
          "containerPort" : 27017,
          "hostPort" : 27017
        }
      ],
      mountPoints = [
        {
          sourceVolume : "efs-mongo-init",
          containerPath : "/docker-entrypoint-initdb.d"
        }
      ]
    },
    {
      name : "node-task",
      image : "${module.aws_module.aws_ecr_url}/${element(module.aws_module.repository_list, 1)}:latest",
      essential : true,
      portMappings : [
        {
          "containerPort" : 3000,
          "hostPort" : 3000
        }
      ],
      dependsOn : [
        {
          "containerName" : "mongo-task"
          "condition" : "START"
        }
      ]
    },
    {
      name : "nginx-task",
      image : "${module.aws_module.aws_ecr_url}/${element(module.aws_module.repository_list, 2)}:latest",
      essential : true,
      portMappings : [
        {
          "containerPort" : 80,
          "hostPort" : 80
        }
      ],
      dependsOn : [
        {
          "containerName" : "node-task",
          "condition" : "START"
        }
      ]
    }
  ])

  volume {
    name = "efs-mongo-init"

    efs_volume_configuration {
      file_system_id = aws_efs_file_system.efs_mongo.id
      root_directory = "../../deploy/mongo"
    }
  }


  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
}

resource "aws_ecs_service" "my_first_service" {
  name            = "my-first-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "nginx-task"
    container_port   = 80
  }

  network_configuration {
    subnets = [
      aws_default_subnet.default_subnet_a.id,
      /*aws_default_subnet.default_subnet_b.id,
      aws_default_subnet.default_subnet_c.id*/
    ]
    assign_public_ip = true
    security_groups  = [aws_security_group.service_security_group.id]
  }
}

resource "aws_security_group" "service_security_group" {
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    # Only allowing traffic in from the load balancer security group
    security_groups = [aws_security_group.load_balancer_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
