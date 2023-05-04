# 🚀 Folder Structure

##   Environment
    We can create multiple environments here like Development, UAT and Production 
    [Here I've created only development and add tf file to build infra].
## Modules
    We can make use of modules to avoid repetition of code.
    [All environments can make use of modules]
##   Pipeline
    We have pipelines for building your Application, creating IAC and cleanup resources when required.

## ✨	Environment Based Infrastructure As Code (IAC):

### [IaC Codebase](https://github.com/himani2203/react-and-spring-data-rest/tree/main/workspace/environment/development)

Here, we are creating following services inside.

### Resource Group
- To have all resources together and a lock to it so that no one can destroy resources.
### ACR
- To store our docker images
### Service Principal
- This SP is required to create Service Connection using Docker Registry 
- In Azure Devops -> Project Setting (Under Pipelines) 
- Giving ACR Push role, so that we can push docker images to Registry.
### App-Service
- Creating PaaS Service to deploy our application both backend and frontend, we have integrated App services with following.
    - #### App-Insights to monitor data
    - #### Enabled diagnostic-settings to check logs if required in case of any app-service failures
    - #### Added Webhooks for continous deployments, whenever a new image is pushed to ACR.
    - #### Auto-scale app services based on the rule set to it

## ✨	Modules
### ✨ [Modules codebase](https://github.com/himani2203/react-and-spring-data-rest/tree/main/workspace/modules)
- Reusable code base

## ✨	Pipeline:

### ✨ [Infrastructure Pipeline](https://github.com/himani2203/react-and-spring-data-rest/tree/main/workspace/pipeline/infrastructure)
- Please create respective Service Connection(Azure Resource Manager)
- Have state file for each Environment you deploy
- We can remove environment during runtime as per the requirement.
- Please create Environments under Pipelines in Azure Devops with approvals to hold the Apply for review.

### ✨ [Cleanup Pipeline](https://github.com/himani2203/react-and-spring-data-rest/tree/main/workspace/pipeline/cleanup)
- This pipeline is used to Cleanup infrastructure based on ResourceGroup.
- Please create Variable Groups across different Environments.
- To store client_id, client_secret and subscription_id
- We can use same Service Connection what we are using for creating infrastructure

### ✨ [Application Pipeline](https://github.com/himani2203/react-and-spring-data-rest/tree/main/workspace/pipeline/application)
- This pipeline have separate backend and frontend pipelines to build to application code and create docker image and push images to ACR
- Create Service Connection using Docker Registry for each environment as there will be different ACRs and SPs across subscription.