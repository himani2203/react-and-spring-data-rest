terraform {
  backend "azurerm" {
    key = "dva2-npdev000.tfstate"
    resource_group_name  = "rgrp-dva2-np-hub000"
    storage_account_name = "saccdva2npdev000"
    container_name       = "terraform-state"
  }

  required_providers {

    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.35.0"
    }

    azuread = {
      source = "hashicorp/azuread"
      version = "2.31.0"
    }

  }
 
  #required_version = ">= 1.3.0, <=1.3.9"
}

provider "azuread" {
}

provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
    key_vault {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted_key_vaults = true
    }
  }
}
