# API Gateway security group
resource "aws_security_group" "gateway_sg" {
  name        = "gateway-sg"
  description = "Allow HTTP from internet and SSH from my IP"
  vpc_id      = aws_vpc.main.id

  # HTTP from anywhere (for demo; restrict in real world)
  ingress {
    description = "HTTP"
    from_port   = var.gateway_http_port
    to_port     = var.gateway_http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH only from your IP or office CIDR
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # CHANGE THIS to your IP for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gateway-sg"
  }
}

# Worker security group
resource "aws_security_group" "worker_sg" {
  name        = "worker-sg"
  description = "Allow RPC from gateway and other workers"
  vpc_id      = aws_vpc.main.id

  # RPC port from gateway SG
  ingress {
    description = "RPC from gateway"
    from_port   = var.worker_rpc_port
    to_port     = var.worker_rpc_port
    protocol    = "tcp"
    security_groups = [
      aws_security_group.gateway_sg.id
    ]
  }

  # RPC port from other workers (mesh)
  ingress {
    description = "RPC from workers"
    from_port   = var.worker_rpc_port
    to_port     = var.worker_rpc_port
    protocol    = "tcp"
    security_groups = [
      aws_security_group.worker_sg.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "worker-sg"
  }
}