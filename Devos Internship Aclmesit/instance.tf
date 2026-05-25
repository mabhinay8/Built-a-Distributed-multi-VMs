locals {
  # Build a comma-separated list of worker endpoints host:port
  worker_endpoints = [
    for idx, inst in aws_instance.worker :
    "${inst.private_ip}:${var.worker_rpc_port}"
  ]
}

resource "aws_instance" "gateway" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.gateway_sg.id]
  key_name               = var.key_name
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/scripts/gateway-userdata.sh", {
    # passing through unused vars is fine; or use env in script
  })

  tags = {
    Name = "inference-gateway"
    Role = "gateway"
  }
}

resource "aws_instance" "worker" {
  count                  = var.worker_count
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.worker_sg.id]
  key_name               = var.key_name
  associate_public_ip_address = false

  user_data = file("${path.module}/scripts/worker-userdata.sh")

  tags = {
    Name = "inference-worker-${count.index}"
    Role = "worker"
  }
}