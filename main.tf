#Security Group of EC2
resource "aws_security_group" "ec2-sg" {
  name        = "ec2-sg"
  description = "Allow inbound rules"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30000
    to_port     = 40000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/18"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/18"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Generate Key Pair for EC2
resource "tls_private_key" "this" {
  algorithm = "RSA"
}

resource "local_file" "private_key" {
  #  content         = tls_private_key.this.private_key_pem
  sensitive_content = tls_private_key.this.private_key_pem
  filename          = join(".", [var.key_name, "pem"])
  file_permission   = "0600"
}

## AWS KEY_PAIR MODULE ##
module "key-pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "1.0.0"

  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}

#Random Public Subnet
resource "random_shuffle" "public_subnet_ids" {
  input = var.public_subnet_ids
  #  result_count = length(var.public_subnet_ids)
  result_count = var.spot_instance.num_of_instance
}

#Random Private Subnet
resource "random_shuffle" "private_subnet_ids" {
  input        = var.private_subnet_ids
  result_count = var.spot_instance.num_of_instance
}

resource "random_shuffle" "user_data_file" {
  input        = fileset(path.module, "file/*.txt")
  result_count = var.spot_instance.num_of_instance
}

#Create EC2 as Spot instance
resource "aws_spot_instance_request" "ec2_spot" {
  count                  = var.spot_instance.num_of_instance
  ami                    = var.spot_instance.ami
  spot_price             = var.spot_instance.spot_type
  instance_type          = var.spot_instance.instance_type
  spot_type              = var.spot_instance.spot_type
  user_data              = file(random_shuffle.user_data_file.result[count.index])
  subnet_id              = var.spot_instance.internal ? random_shuffle.private_subnet_ids.result[count.index] : random_shuffle.public_subnet_ids.result[count.index]
  wait_for_fulfillment   = var.spot_instance.wait_for_fulfillment
  key_name               = module.key-pair.key_pair_key_name
  vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]
}
