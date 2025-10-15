variable "environment" {
  description = "Environment name"
  type        = string
  default     = "test"
}

resource "null_resource" "backend_test" {
  provisioner "local-exec" {
    command = "echo 'Backend test for ${var.environment}'"
  }
}

output "environment" {
  value = var.environment
}
