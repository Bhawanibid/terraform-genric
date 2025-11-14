terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.50.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name = " "
  #   storage_account_name = " "
  #   container_name = " "
  #   key = " "
  # }
}

provider "azurerm" {
  features {}
  subscription_id ="c0748677-9808-4356-8816-dc8088c5bb59"
}