variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "test-project"
}

resource "null_resource" "variable_backend_test" {
  provisioner "local-exec" {
    command = "echo 'Variable backend test for ${var.project}-${var.environment}'"
  }
}

output "state_path" {
  value = "${var.project}-${var.environment}.tfstate"
}
