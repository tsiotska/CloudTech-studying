## Jenkins pipeline running terraform infra

**Installed Jenkins in WSL2 locally, also port forwarded to the
host machine and exposed to the internet using `ngrok` tool**
> Note: ngrok doesn't provide static ip address

![](screenshots/jenkins_running.png)

**Next, moved to jenkins bash and generated deploy keys**

![](screenshots/jenkins_ssh.png)
![](screenshots/deploy_keys.png)

**Configured aws credentials inside jenkins server**

![](screenshots/jenkins_aws_creds.png)

**Registered github webhook**

![](screenshots/webhook_req.png)

**Bound terraform installation dir**

![](screenshots/terraform_plugin.png)

**Configured jenkins pipeline**

![](screenshots/pipeline_config_url.png)

**Jenkinsfile that lies in develop branch**

``` jenkinsfile
pipeline {
agent any

    stages {
        stage('Infra init') {
            steps {
                dir('./terraform-aws/ecs-module') {
                    sh 'terraform init'
                }
            }
        }
        stage('Infra Plan') {
            steps {
                dir('./terraform-aws/ecs-module') {
                    sh 'terraform plan'
                }
            }
        }
    }
}
```

**Pipeline of `terraform init` and `terraform plan` succeeded**

![](screenshots/pipeline_success.png)
![](screenshots/plan_logs.png)


