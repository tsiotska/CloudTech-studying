## Deploying an AWS ECS Cluster with Terraform

<details>
<br/>
<summary>Registration and User creation</summary>

![](screenshots/registered.png)
![](screenshots/user.png)


Also AWS CLI installed

![](screenshots/aws_version.png)

</details>
<br/>
<details>
<br/>
<summary>Elastic Container Registry</summary>

#### AWS and docker provider configuration with credentials 

![](screenshots/provider.png)
> aws_caller_identity and aws_ecr_authorization_token are data sources that automatically
exports credentials for an ECR

<br/>

Defined variable of repositories as list and used the `for_each` meta-argument and `toset` function
to declare multiple similar resources

![](screenshots/vars.png)

![](screenshots/erc.png)

>After repos had been created, removed repo state from terraform, so it'd not be destroyed
when switching it to a data source

#### Created repositories: 

![](screenshots/repos.png)

<br/> 
  
#### While building images, faced issue below and couldn't fix it.

![](screenshots/issue.png)
`docker_registry_image` strips the file permissions during handling of the context archive

https://github.com/kreuzwerker/terraform-provider-docker/issues/293

<br/>
  
Thus i resorted to traditional method: built images using docker-compose,
tagged and push with docker cli commands

![](screenshots/tags.png)
![](screenshots/aws_nginx.png)
![](screenshots/aws_node.png)
![](screenshots/aws_mongo.png)

</details>
