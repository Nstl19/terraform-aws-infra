variable "aws_region" {
  default = "ap-south-1"
}

variable "project_name" {
  default = "my-terraform-project"
}

variable "instance_type" {
  default     = "t3.micro"
  description = "EC2 Instance Type"
  type        = string
}

variable "ami_id" {
  # Amazon Linux 2023 Kernel-6.1 AMI
  default     = "ami-0d176f79571d18a8f"
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "key_name" {
  type        = string
  description = "Existing EC2 key pair name"
}
