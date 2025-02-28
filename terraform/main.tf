module "server" {
  source = "./modules/server"

  instance_type       = var.instance_type
  ami                = var.ami
  security_group_name = var.security_group_name
  server_count       = var.server_count
  domain         = var.domain
  hosted_zone_id = var.hosted_zone_id
  key_name       = var.key_name
  region       = var.region 
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
}
