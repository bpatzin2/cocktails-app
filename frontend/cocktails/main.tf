terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "cocktail_nextjs_repo" {
  name = "cocktail-nextjs-repo"
}

#######################################################

# variable "image_tag" {
#   type = string
#   nullable = false
# }

# resource "aws_default_vpc" "default_vpc" {
# }

# # Providing a reference to our default subnets
# resource "aws_default_subnet" "default_subnet_a" {
#   availability_zone = "us-east-1a"
# }

# resource "aws_default_subnet" "default_subnet_b" {
#   availability_zone = "us-east-1b"
# }

# resource "aws_default_subnet" "default_subnet_c" {
#   availability_zone = "us-east-1c"
# }

# resource "aws_ecs_cluster" "cocktail_nextjs_cluster" {
#   name = "cocktail-nextjs-cluster"
# }

# resource "aws_ecs_task_definition" "cocktail_nextjs_task" {
#   family                   = "cocktail-nextjs-task" # Naming our first task
#   container_definitions    = <<DEFINITION
#   [
#     {
#       "name": "cocktail-nextjs-task",
#       "image": "${aws_ecr_repository.cocktail_nextjs_repo.repository_url}:${var.image_tag}",
#       "essential": true,
#       "portMappings": [
#         {
#           "containerPort": 3000,
#           "hostPort": 3000
#         }
#       ],
#       "memory": 512,
#       "cpu": 256
#     }
#   ]
#   DEFINITION
#   requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
#   network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
#   memory                   = 512         # Specifying the memory our container requires
#   cpu                      = 256         # Specifying the CPU our container requires
#   execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole2.arn}"
# }

# resource "aws_iam_role" "ecsTaskExecutionRole2" {
#   name               = "ecsTaskExecutionRole2"
#   assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
# }

# data "aws_iam_policy_document" "assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
#   role       = "${aws_iam_role.ecsTaskExecutionRole2.name}"
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

# resource "aws_ecs_service" "cocktail_nextjs_service" {
#   name            = "cocktail-nextjs-service"                             
#   cluster         = "${aws_ecs_cluster.cocktail_nextjs_cluster.id}" 
#   task_definition = "${aws_ecs_task_definition.cocktail_nextjs_task.arn}"
#   launch_type     = "FARGATE"
#   desired_count   = 3 # Setting the number of containers we want deployed to 3
#    network_configuration {
#     subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
#     assign_public_ip = true                                                # Providing our containers with public IPs
#     security_groups  = ["${aws_security_group.service_security_group.id}"] # Setting the security group
#   }
#   load_balancer {
#     target_group_arn = "${aws_lb_target_group.target_group.arn}" # Referencing our target group
#     container_name   = "${aws_ecs_task_definition.cocktail_nextjs_task.family}"
#     container_port   = 3000 # Specifying the container port
#   }
# }

# resource "aws_alb" "application_load_balancer" {
#   name               = "cocktail-nextjs-lb" # Naming our load balancer
#   load_balancer_type = "application"
#   subnets = [ # Referencing the default subnets
#     "${aws_default_subnet.default_subnet_a.id}",
#     "${aws_default_subnet.default_subnet_b.id}",
#     "${aws_default_subnet.default_subnet_c.id}"
#   ]
#   # Referencing the security group
#   security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
# }

# # Creating a security group for the load balancer:
# resource "aws_security_group" "load_balancer_security_group" {
#   vpc_id      = aws_default_vpc.default_vpc.id

#   ingress {
#     from_port   = 80 # Allowing traffic in from port 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # Allowing traffic in from all sources
#   }

#   egress {
#     from_port   = 0 # Allowing any incoming port
#     to_port     = 0 # Allowing any outgoing port
#     protocol    = "-1" # Allowing any outgoing protocol 
#     cidr_blocks = ["0.0.0.0/0"] # Allowing traffic out to all IP addresses
#   }
# }

# resource "aws_lb_target_group" "target_group" {
#   name        = "target-group"
#   port        = 3000
#   protocol    = "HTTP"
#   target_type = "ip"
#   vpc_id      = "${aws_default_vpc.default_vpc.id}" # Referencing the default VPC
#   health_check {
#     healthy_threshold = "2"
#     unhealthy_threshold = "6"
#     interval = "30"
#     matcher = "200,301,302"
#     path = "/"
#     protocol = "HTTP"
#     timeout = "5"
#   }
# }

# resource "aws_lb_listener" "listener" {
#   load_balancer_arn = "${aws_alb.application_load_balancer.arn}" # Referencing our load balancer
#   port              = "80"
#   protocol          = "HTTP"
#   default_action {
#     type             = "forward"
#     target_group_arn = "${aws_lb_target_group.target_group.arn}" # Referencing our tagrte group
#   }
# }

# resource "aws_security_group" "service_security_group" {
#   vpc_id      = aws_default_vpc.default_vpc.id

#  ingress {
#     from_port = 0
#     to_port   = 0
#     protocol  = "-1"
#     # Only allowing traffic in from the load balancer security group
#     security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
#   }

#   egress {
#     from_port   = 0 # Allowing any incoming port
#     to_port     = 0 # Allowing any outgoing port
#     protocol    = "-1" # Allowing any outgoing protocol 
#     cidr_blocks = ["0.0.0.0/0"] # Allowing traffic out to all IP addresses
#   }
# }

