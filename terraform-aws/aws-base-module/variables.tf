variable "region" {
  description = "AWS region to create resources in"
  type  = string
  default = "eu-central-1"
}

variable "repository_list" {
  description = "List of repository names"
  type = list
  default = ["aws_mongo", "aws_node", "aws_nginx"]
}

output "region" {
  value = var.region
}

output "repository_list" {
  value = var.repository_list
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

output "aws_ecr_authorization_token" {
  value = data.aws_ecr_authorization_token.token
}

output "aws_ecr_url" {
  value = local.aws_ecr_url
}

output "aws_domain_name" {
  value = "insanevitalik"
}