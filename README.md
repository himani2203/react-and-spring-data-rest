# react-and-spring-data-rest

### Pre-Requisite to build the project:

1) Create a new Azure Repo from Azure Devops and push the code (https://github.com/himani2203/react-and-spring-data-rest)
2) Since i am using Terraform here to build my Infrastructure, Make sure you have a storage account and a blob container to store tf state files (Separate RG itself so that later when we cleanup our code, our state file should not be impacted and maintain Desired state).
3) Create Service Principal to run Terraform locally and from pipelines in Azure DevOps with Contributor access to Subscription.
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal-in-the-azure-portal
4) Make sure you have different Subscriptions across Environments (Dev/UAT/Prod) with their respective Service principals, ACRs, Service Connection etc.


#### Build Application code base Image using Dockerfile for Sprinboot (https://github.com/himani2203/react-and-spring-data-rest/tree/main/backend) and React (https://github.com/himani2203/react-and-spring-data-rest/tree/main/frontend) using Application Pipelines (https://github.com/himani2203/react-and-spring-data-rest/tree/main/workspace/pipeline/application)

#### Deploy the application across different environments on the target infrastructure using Infrastructure Pipeline (https://github.com/himani2203/react-and-spring-data-rest/blob/main/workspace/pipeline/infrastructure/azure-pipelines.yml)

#### Infrastructure can be monitored and audited using Application Insights:
To access application, I am deploying on Azure Web Apps and added Instrumentation Key and dependency in application code (https://github.com/himani2203/react-and-spring-data-rest/blob/main/src/main/resources/application.properties and https://github.com/himani2203/react-and-spring-data-rest/blob/main/pom.xml) and in Web-Apps's app_setting

#### We can also invite external or multiple personal accounts to manage our Infrastructure from Azure DevOps.

Refer Link : https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/add-external-user?view=azure-devops




