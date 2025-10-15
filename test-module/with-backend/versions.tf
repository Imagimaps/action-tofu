terraform {
  required_version = ">= 1.0"
  
  backend "local" {
    path = "terraform.tfstate"
  }
  
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}
