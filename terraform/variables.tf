variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "ami" {
  description = "Ubuntu 22.04 AMI ID"
  type        = string
  default     = "ami-0e1bed4f06a3b463d"
}

variable "security_group_name" {
  description = "Security Group Name"
  type        = string
  default     = "todo-app-sg"
}

variable "server_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}
variable "domain" {
  description = "Domain name for the application"
  type        = string
  default = "ayinde.name.ng"
}

variable "hosted_zone_id" {
  description = "Route53 Hosted Zone ID"
  type        = string
  default = "your hosted zone id"
}

variable "key_name" {
  description = "SSH key name"
  type        = string
  default = "ajo-devops-key"
  
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}