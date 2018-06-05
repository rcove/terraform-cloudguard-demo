variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.

Example: ~/.ssh/terraform.pub
DESCRIPTION
}

variable "key_name" {
  description = "Desired name of AWS key pair"
}
variable "aws_vpc_cidr" {
}
variable "aws_external1_subnet_cidr" {
}
variable "aws_external2_subnet_cidr" {
}
variable "aws_webserver1_subnet_cidr" {
}
variable "aws_webserver2_subnet_cidr" {
}
variable "my_user_data" {
}
variable "ubuntu_user_data" {
}
variable "externaldnshost" {
}
variable "cg_size" {
}
variable "ws_size" {
}
variable "r53zone" {
}
variable "SICKey" {
}
variable "AllowUploadDownload" {
}
variable "pwd_hash" {
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "ap-southeast-2"
}
variable "primary_az" {
  description = "primary AZ"
  default     = "ap-southeast-2a"
}
variable "secondary_az" {
  description = "secondary AZ"
  default     = "ap-southeast-2b"
}
# Check Point R80 BYOL
data "aws_ami" "chkp_ami" {
  most_recent      = true
  filter {
    name   = "name"
    values = ["Check Point CloudGuard IaaS GW BYOL R80.10-*"]
  }
  owners = ["679593333241"]
}

# Ubuntu Image
data "aws_ami" "ubuntu_ami" {
  most_recent      = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
}



