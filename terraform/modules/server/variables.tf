variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ami" {
  description = "Ubuntu AMI ID"
  type        = string
}

variable "security_group_name" {
  description = "Security Group Name"
  type        = string
}

variable "server_count" {
  description = "Number of instances to create"
  type        = number
}

variable "domain" {
  description = "Domain name for the application"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route53 Hosted Zone ID"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
  
}
variable "region" {
  description = "Aws region"
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