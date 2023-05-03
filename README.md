# react-and-spring-data-rest

### Pre-Requisite to build the project:

1) Created the Azure Repo from Azure Devops and push the code (react-and-spring-data-rest.zip)
2) Since i am using Terraform here to build my Infrastructure, Make sure you have a storage account and a blob container to store tf state files (Separate RG itself so that later when we cleanup our code, our state file should not be impacted and maintain Desired state).
3) Create Service Principal to run Terraform locally and from pipelines in Azure DevOps with Contributor access to Subscription.
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal-in-the-azure-portal
4) Make sure you have different Subscriptions across Environments (Dev/UAT/Prod) with respective Service principals, ACRs, Service Connection etc.


