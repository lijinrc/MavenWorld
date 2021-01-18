provider "azurerm" {
  version = "2.43.0"
  features {}
}

# Ignore if created previously in service_principles/principle.tf
# Create a Service Principle from Azure Portal > Azure AD > App Registrations > Create a New Registration and then copy the Client ID and Tenant ID
# ARM_CLIENT_ID 7040f626-1e9f-46e4-8c03-e91fddea6633
# ARM_TENANT_ID 30c5f505-0191-437c-9821-f92247d11911

# Open the new Service Principle Registration > Certificates and Secrets > New Client Secret and Copy the Secret value field
# ARM_CLIENT_SECRET tOl2728~O1j~s.aoKd2gyxu5H-vni69MMJ

# Create a Subscription from Azure Portal > Subscriptions 
# Copy the Subscription ID
# Open the Subscription > Access Control > Add a Role Assignments > Select Role as Contributor > Select the Service Principle created previously from Select dropdown and Save
# ARM_SUBSCRIPTION_ID 45d80a11-58e9-41ff-bee8-312ca72b160e

# Save the Terraform tfstate on a Azure backend:
# On AzureDevOps > Library > Create a Variable Group > Save all 4 variables from above
# On AzurePortal > Create a Resource Group (if not already created)
# On AzurePortal > Create Resource > Storage Accounts > Create New Storage Account > Open the Storage Acc > Choose Container (Folder) > Create a New Container

# Saving the .tfstate on Azure Storage > Folder/Container created above
terraform {
  backend "azurerm" {
    resource_group_name  = "my_rg"
    storage_account_name = "mystoragelijin"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

variable "newimagebuild" {
	type = "string"
	description = "Latest Image BuildId received from Azure DevOps"
}

resource "azurerm_container_group" "tf_cg" {
  name                = "tf_cg"
  location            = azurerm_resource_group.tf_rg.location
  resource_group_name = azurerm_resource_group.tf_rg.name

  ip_address_type = "public"
  dns_name_label  = "lijin"
  os_type         = "Linux"

  container {
    name   = "nginx"
    image  = "lijinrc/nginx:${var.newimagebuild}"
    cpu    = "1"
    memory = "1"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
