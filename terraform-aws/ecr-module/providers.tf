provider "docker" {
  version = "~> 2.6"
  host = "npipe:////.//pipe//docker_engine"

  registry_auth {
    address  = module.aws_module.aws_ecr_url
    username = module.aws_module.aws_ecr_authorization_token.user_name
    password = module.aws_module.aws_ecr_authorization_token.password
  }
}