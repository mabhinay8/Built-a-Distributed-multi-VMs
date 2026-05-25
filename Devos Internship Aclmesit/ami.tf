data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ami-09ed39e30153c3bf9"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}