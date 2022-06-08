module "aws_module" {
  source = "../aws-base-module"
}

resource "aws_ecs_cluster" "cluster" {
  name = "my-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                   = "aws-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn

  container_definitions = jsonencode([
    {
      name : "aws_mongo",
      # image : aws_ecr_repository.repository["aws_mongo"].repository_url,
      // mongo url below
      image : "${module.aws_module.aws_ecr_url}/${element(module.aws_module.repository_list, 0)}:latest",
      essential : true,
      portMappings : [
        {
          "containerPort" : 27017,
          "hostPort" : 27017
        }
      ]/*,
      mountPoints = [
        *//*{
          sourceVolume : "efs-mongo-init",
          containerPath : "/docker-entrypoint-initdb.d"
        },*//*
        {
          sourceVolume : "efs-data-storage",
          containerPath : "/data.tf/db"
        }
      ]*/
    },
    {
      name : "aws_node",
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
          "containerName" : "aws_mongo"
          "condition" : "START"
        }
      ]
    },
    {
      name : "aws_nginx",
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
          "containerName" : "aws_node",
          "condition" : "START"
        }
      ]
    }
  ])

  /*volume {
    name = "efs-mongo-init"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.efs_mongo.id
      root_directory = "/"
    }
  }*/

  /*volume {
    name = "efs-data-storage"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.efs_mongo.id
      root_directory = "/db"
    }
  }*/
}

resource "aws_ecs_service" "service" {
  depends_on      = [aws_lb_listener.listener]
  name            = "service"
  # enable_execute_command = true
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.id
    container_name   = "aws_nginx"
    container_port   = 80
  }

  network_configuration {
    # Only internal private subnet
    subnets          = aws_subnet.public.*.id
    assign_public_ip = true

    #subnets          = aws_subnet.private.*.id
    security_groups = [aws_security_group.service_security_group.id]
  }
}

resource "aws_security_group" "service_security_group" {
  name        = "service-security-group"
  description = "controls access to the service"
  vpc_id      = aws_vpc.vpc.id

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
