# VPC
resource "aws_vpc" "my_project_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.project_name
  }
}


# Public Subnets
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.my_project_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.my_project_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-2"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "project__igw" {
  vpc_id = aws_vpc.my_project_vpc.id

  tags = {
    Name = "${var.project_name}-project_igw"
  }
}


# Route Table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.my_project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project__igw.id
  }
  tags = {
    Name = "${var.project_name}-route-table"
  }
}

# Route Table Associations
resource "aws_route_table_association" "pub1_association" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "pub2_association" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.route_table.id
}


# Security Group
resource "aws_security_group" "project_sg" {
  name        = "${var.project_name}-sg"
  description = "Security group for ${var.project_name}"
  vpc_id      = aws_vpc.my_project_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}

# IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


# IAM Policy to allow S3 access
resource "aws_iam_role_policy" "s3_policy" {
  name = "${var.project_name}-s3-policy"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          aws_s3_bucket.project_bucket.arn,
          "${aws_s3_bucket.project_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.project_name}-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}


# EC2 Instance
resource "aws_instance" "web_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_1.id
  vpc_security_group_ids      = [aws_security_group.project_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  key_name                    = var.key_name
  associate_public_ip_address = true

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "${var.project_name}-web-server"
  }
}


# S3 Bucket
resource "aws_s3_bucket" "project_bucket" {
  bucket = "${var.project_name}-bucket-${random_id.bucket_id.hex}"

  tags = {
    Name = "${var.project_name}-bucket"
  }
}

resource "random_id" "bucket_id" {
  byte_length = 4
}
