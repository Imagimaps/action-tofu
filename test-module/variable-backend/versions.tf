terraform {
  required_version = ">= 1.0"
  
  backend "local" {
    path = "${var.project}-${var.environment}.tfstate"
  }
  
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}
