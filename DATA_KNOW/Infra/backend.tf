terraform {
  required_version = ">= 1.5.0"

  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = "~> 1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # El estado se guarda en Azure Storage. 
  # Las llaves de acceso se pasan vía pipeline (ARM_ACCESS_KEY)
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sttfstateretailnova"
    container_name       = "tfstate"
    key                  = "fabric/terraform.tfstate"
  }
}

provider "fabric" {}

provider "azurerm" {
  features {}
}