variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  description = "Name of the AWS Key Pair"
}

variable "public_key_path" {
  description = "Path to your public SSH key"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI or Ubuntu AMI"
}
