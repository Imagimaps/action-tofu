variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "instance_count" {
  description = "Number of instances"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

resource "null_resource" "variables_test" {
  count = var.instance_count
  
  provisioner "local-exec" {
    command = "echo 'Instance ${count.index + 1} in ${var.environment}-${var.region} with tags: ${jsonencode(var.tags)}'"
  }
}

output "summary" {
  value = {
    environment    = var.environment
    region        = var.region
    instance_count = var.instance_count
    tags          = var.tags
  }
}
