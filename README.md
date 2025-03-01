# Stage 4 Infrastructure Repository

This repository contains Infrastructure as Code (IaC) for deploying a multi-service application using Terraform and Ansible on AWS.

## Repository Links

- **Infrastructure Repository**: [stage4-infra-repo](https://github.com/johnayinde/devops-terraform-ansible)
- **Containerized Application Repository**: [DevOps-Stage-4](https://github.com/johnayinde/DevOps-Stage-4)

## Prerequisites

- Terraform >= 1.0.0
- Ansible >= 2.9
- AWS CLI configured
- SSH key pair named "xyz-dev"

## Infrastructure Components

- **EC2 Instance**:

  - Type: t2.micro
  - AMI: Ubuntu 22.04
  - Root Volume: 10GB GP3

- **Networking**:

  - Elastic IP
  - Security Group (ports: 22, 80, 443, 6379, 8080)
  - Route53 DNS configuration

- **Application Stack**:

  - Docker containers orchestrated with Docker Compose
  - Traefik for reverse proxy
  - Java 17 runtime

## Quick Start

1. **Clone the Repository**

```bash
git clone https://github.com/johnayinde/devops-terraform-ansible.git
cd devops-terraform-ansible
```

2. **Initialize Terraform**

```bash
cd terraform
terraform init
```

3. **Deploy Infrastructure**

```bash
terraform apply -auto-approve
```

4. **Deploy Application (Using Ansible)**

```bash
cd ..
ansible-playbook -i ansible/inventory ansible/playbook.yml
```

## Configuration Files

### Terraform Variables

```hcl
# filepath: /terraform/variables.tf
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "domain" {
  description = "Domain name for the application"
  type        = string
  default     = "your domain name"
}
```

### Ansible Playbook

```yaml
- hosts: all
  roles:
    - dependencies
    - deployment
```

## Environment Variables

Create a `.env` file in your application directory:

```ini
# Application Configuration
PORT=8080
AUTH_API_ADDRESS=http://auth-api:8081
TODOS_API_ADDRESS=http://todos-api:8082
JWT_SECRET=myfancysecret
REDIS_HOST=redis-queue
REDIS_PORT=6379
```

## Deployment Process

1. **Infrastructure Provisioning**

   - EC2 instance creation
   - Security group configuration
   - Elastic IP allocation
   - DNS record setup

2. **Application Deployment**

   - System dependencies installation
   - Docker network creation
   - Application services deployment

## Management Commands

**SSH Access**:

```bash
ssh -i ~/your-key-pair.pem ubuntu@$(terraform output -raw public_ip)
```

**Check Application Status**:

```bash
docker ps
docker-compose logs -f
```

## Troubleshooting

1. **SSH Connection Issues**

```bash
chmod 400 ~/(your-key-pair.pem)
```

2. **Docker Network Issues**

```bash
sudo docker network create web
sudo systemctl restart docker
```

3. **DNS Issues**

```bash
dig +short your-domain-name
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Submit a pull request
