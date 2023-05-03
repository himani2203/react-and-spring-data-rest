### Here we have three folders:
1) environment : We can create multiple environments here like development, uat and production (Here i have created only development and add tf file to build infra).
2) modules : We can make use of modules to avoid repetition of code. (All environments can make use of modules)
3) pipeline : We have pipelines for building our application, creating IAC and cleanup resources when required.

#### 	Environment Based IAC Code: https://github.com/himani2203/react-and-spring-data-rest/tree/main/workspace/environment/development: Here, we are creating following services inside:

1) Resource Group to have all resources together and a lock to it so that no one can destroy resources.
2) ACR: to store our docker images
3) Service Principal: This SP is required to create Service Connection using Docker Registry in Azure Devops -> Project Setting (Under Pipelines) and giving ACR Push role, so that we can push docker images to Registry.
4.	App-Service: Creating Paas Service to deploy our application both backend and frontend, we have integrated App services with:
•	App-Insights to monitor data
•	enabled diagnostic-settings to check logs if required in case of any app-service failures
•	added Webhooks for continous deployments, whenever a new image is pushed to ACR.
•	auto-scale app services based on the rule set to it

 #### 	Modules: https://github.com/himani2203/react-and-spring-data-rest/tree/main/workspace/modules
 
#### 	pipeline:
  
 https://github.com/himani2203/react-and-spring-data-rest/tree/main/workspace/pipeline/infrastructure
  - Please create respective Service Connection(Azure Resource Manager) and have state file for each environments you deploy (we can remove environment during runtime as per the requirement)
  - Please create Environments under Pipelines in Azure Devops with approvals to hold the Apply for review.
 
  https://github.com/himani2203/react-and-spring-data-rest/tree/main/workspace/pipeline/cleanup
  - This pipeline is use to cleanup infrastrure based on ResourceGroup
  - Please create Variable Groups across different Environments to store client_id, client_secret and subscription_id
  - We can use same Service Connection what we are using for creating infrastructure
  
  https://github.com/himani2203/react-and-spring-data-rest/tree/main/workspace/pipeline/application
   - This pipeline have separate backend and frontend pipelines to build to application code and create docker image and push images to ACR
   - Create Service Connection using Docker Registry for each environment as there will be different ACRs and SPs across subscription.
 
