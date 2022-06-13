## Deploying an AWS ECS Cluster with Terraform

<details>
<summary>Registration and User creation</summary>
<br/>

![](screenshots/registered.png)
![](screenshots/user.png)

Also AWS CLI installed

![](screenshots/aws_version.png)

</details>

<br/>

<details>

<summary>Elastic Container Registry</summary>

#### AWS and docker provider configuration with credentials 

![](screenshots/provider.png)
> `aws_caller_identity` and `aws_ecr_authorization_token` are data sources that automatically
exports credentials for an ECR

<br/>

**ECR resources**

![](screenshots/ecr.png)
> For using repos as data source, the resources should be removed from state before switching

#### Created repositories:

![](screenshots/repos.png)

<br/>

**While building images, faced issue below and couldn't fix it.**

![](screenshots/issue.png)
`docker_registry_image` strips the file permissions during handling of the context archive

https://github.com/kreuzwerker/terraform-provider-docker/issues/293

<br/>
  
Thus i resorted to traditional method: built images using `docker-compose`,
tagged and push with `docker cli` commands

![](screenshots/tags.png)
![](screenshots/aws_nginx.png)
![](screenshots/aws_node.png)
![](screenshots/aws_mongo.png)

</details>

<br/>

<details>
<summary>Elastic Container Service</summary>
<br/>

**Adding this second service, i separated infra as follows:**

![](screenshots/struct.png)
> So it consists of ECR and ECS modules with its own independent state  
and aws-base-module that represents abstraction

ECS module is too way contentful, so:
https://github.com/tsiotska/CloudTech-studying/tree/develop/terraform-aws/ecs-module

**For ECS there have been created next resources:**
* aws_iam_role (policy_arn: AmazonECSTaskExecutionRolePolicy)
* aws_ecs_cluster
* aws_ecs_service with load_balancer and network_configuration 
* aws_security_group for service network and load balancer
* aws_ecs_task_definition with containers definitions using mongo, node, nginx images from ecr
* aws_vpc with private and public aws_subnet
* private subnet with internet connectivity through nat gateway

<br/>

****
<br/>

**Running app (no bought dns name and https provided):**

![](screenshots/dns_accessed.png)
***
![](screenshots/containers.png)

</details>
