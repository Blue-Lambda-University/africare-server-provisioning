aws_region       = "us-east-1"
instance_type    = "t3.micro"
key_name         = "my-ec2-keypair"                       # Replace with your actual key name in AWS
public_key_path  = "~/.ssh/id_rsa.pub"                   # Path to your public SSH key
ami_id           = "ami-0c02fb55956c7d316"               # Ubuntu 22.04 LTS AMI for us-east-1 (update for your region)
