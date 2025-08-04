variable "vpc_id" {
  description = "VPC ID to associate with the security group"
  type        = string
}

variable "ssh_allowed_ip" {
  description = "CIDR block allowed to SSH"
  type        = string
}

variable "http_access_cidr" {
  description = "CIDR block allowed to access HTTP"
  type        = string
}
