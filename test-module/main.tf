variable "environment" {
  description = "Environment name"
  type        = string
  default     = "test"
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo 'Hello from ${var.environment}'"
  }
}

output "environment" {
  value = var.environment
}
