variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type for gateway and workers"
  type        = string
  default     = "t3.micro"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "key_name" {
  description = "Existing EC2 key pair name for SSH"
  type        = string
}

variable "worker_count" {
  description = "Number of worker instances"
  type        = number
  default     = 3
}

variable "gateway_http_port" {
  description = "Port exposed by the API gateway"
  type        = number
  default     = 80
}

variable "worker_rpc_port" {
  description = "Port used by workers for RPC"
  type        = number
  default     = 50051
}