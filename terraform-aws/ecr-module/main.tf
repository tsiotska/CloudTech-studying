terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

module "aws_module" {
  source = "../aws-base-module"
}

## Create ECR repository
resource "aws_ecr_repository" "repository" {
  for_each             = toset(module.aws_module.repository_list)
  name                 = each.key
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

/*resource "aws_ecrpublic_repository" "repository" {
  for_each             = toset(module.aws_module.repository_list)
  provider             = module.aws_module.provider // aws.us_east_1
  repository_name      = each.key
}*/

## After repository creation use it as data source, but remove repo from state before
/*
data "aws_ecr_repository" "repository" {
  for_each = toset(module.aws_module.repository_list)
  name = each.key
}
*/

## Build docker images and push to ECR
# https://github.com/kreuzwerker/terraform-provider-docker/issues/293
/*resource "docker_registry_image" "image" {
  for_each = toset(var.repository_list)
  name = "${aws_ecr_repository.repository[each.key].repository_url}:latest"
  keep_remotely = true

  build {
    context = "../"
    dockerfile = "./deploy/${each.key}/Dockerfile"
  }
}*/
