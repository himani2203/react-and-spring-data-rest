### Here we have three folders:
1) environment : We can create multiple environments here like development, uat and production (Here i have created only development and add tf file to build infra).
2) modules : We can make use of modules to avoid repetition of code. (All environments can make use of modules)
3) pipeline : We have pipelines for building our application, creating IAC and cleanup resources when required.

In https://github.com/himani2203/react-and-spring-data-rest/tree/main/workspace/environment/development, we are creating following services:

1) Resource Group to have all resources together and a lock to it so that no one can destroy resources.
2) ACR: to store our docker images
3) Service Principal: This SP is required to create Service Connection using Docker Registry in Azure Devops -> Project Setting (Under Pipelines) and giving ACR Push role, so that we can push docker images to Registry.
4) App-Service: Creating Paas Service to deploy our application both backend and frontend, we have integrated App services with 
 a) App-Insights to monitor data 
 b) enabled diagnostic-settings to check logs if required in case of any app-service failures
 c) added Webhooks for continous deployments, whenever a new image is pushed to ACR.
 d) auto-scale app services based on the rule set to it.
 
 Created three modules to create app-services: https://github.com/himani2203/react-and-spring-data-rest/tree/main/workspace/modules
 
