## What is this?
This is my course project for Softserve Academy, focusing on DevOps development.

**Switch branches** to navigate between specific topics.

The course covered:
- [Virtual Machine](https://github.com/tsiotska/CloudTech-studying/tree/VM)
- [Linux](https://github.com/tsiotska/CloudTech-studying/tree/linux)
- [Git](https://github.com/tsiotska/CloudTech-studying/tree/git)
- [Nginx & stack init](https://github.com/tsiotska/CloudTech-studying/tree/nginx)
- [Docker](https://github.com/tsiotska/CloudTech-studying/tree/docker)
- [Terraform](https://github.com/tsiotska/CloudTech-studying/tree/terraform)
- [Jenkins](https://github.com/tsiotska/CloudTech-studying/tree/jenkins)
- [AWS](https://github.com/tsiotska/CloudTech-studying/tree/aws)
- [Prometheus & Grafana](https://github.com/tsiotska/CloudTech-studying/tree/prometheus)

The `develop` branch serves as the main code source.

### Dev scripts
Once your AWS CLI is configured (with aws configure), Terraform will automatically use the credentials stored in ~/.aws/credentials.

**To run locally with https:**

`docker-compose -f docker-compose.yaml up --build`

**To prebuild images for aws:**

`docker-compose -f docker-compose.yaml -f docker-compose.prod.yaml build`

**To enter container:**

docker exec -t -i container_id  /bin/sh