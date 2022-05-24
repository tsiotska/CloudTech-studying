module "aws_module" {
  source = "../aws-base-module"
}

resource "aws_ecs_cluster" "cluster" {
  name = "my-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                   = "aws-task"
  container_definitions    = jsonencode([
    {
      name : "mongo-task",
      # image : aws_ecr_repository.repository["aws_nginx"].repository_url,
      // nginx url below
      image : "${module.aws_module.aws_ecr_url}/${element(module.aws_module.repository_list, 0)}:latest",
      essential : true,
      portMappings : [
        {
          "containerPort": 27017,
          "hostPort": 27017
        }
      ],
    },
    {
      name : "node-task",
      # image : aws_ecr_repository.repository["aws_nginx"].repository_url,
      // nginx url below
      image : "${module.aws_module.aws_ecr_url}/${element(module.aws_module.repository_list, 1)}:latest",
      essential : true,
      portMappings : [
        {
          "containerPort": 3000,
          "hostPort": 3000
        }
      ],
    },
    {
      name : "nginx-task",
      # image : aws_ecr_repository.repository["aws_nginx"].repository_url,
      // nginx url below
      image : "${module.aws_module.aws_ecr_url}/${element(module.aws_module.repository_list, 2)}:latest",
      essential : true,
      portMappings : [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
    }
  ])
  requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_service" "my_first_service" {
  name            = "my-first-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "FARGATE"
  desired_count   = 3

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = aws_ecs_task_definition.task.family
    container_port   = 80 # Specifying the container port
  }

  network_configuration {
    subnets          = [
      aws_default_subnet.default_subnet_a.id,
      aws_default_subnet.default_subnet_b.id,
      aws_default_subnet.default_subnet_c.id
    ]
    assign_public_ip = true
    security_groups  = [aws_security_group.service_security_group.id]
  }
}

resource "aws_security_group" "service_security_group" {
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
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

resource "aws_default_vpc" "default_vpc" {}

resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = "${module.aws_module.region}a"
}

resource "aws_default_subnet" "default_subnet_b" {
  availability_zone = "${module.aws_module.region}b"
}

resource "aws_default_subnet" "default_subnet_c" {
  availability_zone = "${module.aws_module.region}c"
}

resource "aws_alb" "application_load_balancer" {
  name               = "test-lb-tf"
  load_balancer_type = "application"
  subnets = [
    aws_default_subnet.default_subnet_a.id,
    aws_default_subnet.default_subnet_b.id,
    aws_default_subnet.default_subnet_c.id
  ]
  security_groups = [aws_security_group.load_balancer_security_group.id]
}

# Creating a security group for the load balancer:
resource "aws_security_group" "load_balancer_security_group" {
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_default_vpc.default_vpc.id
  health_check {
    matcher = "200,301,302"
    path = "/"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}