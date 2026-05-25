# Built-a-Distributed-multi-VMs
Steps for creating vms using terraform
Overview
This project builds a small distributed inference system on AWS using Terraform.

All networking and virtual machines are created from code, not from the AWS console.

What the infrastructure does
Creates one VPC for the whole system.

Creates a public subnet for the API gateway VM.

Creates a private subnet for the worker VMs.

Attaches an Internet Gateway to let the public subnet reach the internet.

Creates a NAT Gateway so private workers can reach the internet for updates, but are not exposed.
Sets up route tables so:

Public subnet has a route to the Internet Gateway.

Private subnet has a route to the NAT Gateway only.

Security
A security group for the API gateway:

Allows HTTP traffic from the internet on a single port.

Allows SSH from a trusted IP range.

A security group for workers:

Allows RPC traffic only from the gateway and from other workers.

No direct access from the public internet.

Virtual machines
One API gateway EC2 instance in the public subnet.

Multiple worker EC2 instances in the private subnet.

User data scripts run at boot to:

Install dependencies on each VM.

Pull the application code.

Start the gateway and worker services automatically.

Application behavior
The API gateway exposes a JSON HTTP endpoint (for example POST /infer).

The gateway forwards each request to one of the workers over the private subnet.

Workers run the actual inference and send back a JSON response.

The gateway returns this result to the client.

How to deploy
Install Terraform and configure your AWS credentials.

Set the required variables, like AWS region and EC2 key pair name.

Run terraform init to download providers.

Run terraform plan to see what will be created.

Run terraform apply to create the VPC, subnets, security groups, and EC2 instances.

After apply finishes, Terraform prints the public IP of the gateway.

Send HTTP requests to the gateway public IP on the configured port to test inference.
