provider "aws" {
  region = var.aws_region
}

#Create security group with firewall rules
resource "aws_security_group" "my_security_group" {
  name        = var.security_group
  description = "security group for Ec2 instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
}

# Create AWS ec2 instance
#resource "aws_instance" "myFirstInstance" {
#  ami           = var.ami_id
##  key_name = var.key_name
 # instance_type = var.instance_type
 # security_groups= [var.security_group]
 # tags= {
 #   Name = var.tag_name
 # }
#}

resource "aws_instance" "hdfs" {
  ami           = "ami-00ce00765d9093e1e"
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = Jupyter-hdfs
  }
}

resource "aws_instance" "serving" {
  ami           = "ami-07e936751c60cf84d"
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = 	"mlflowServing"
  }
}

resource "aws_instance" "datalake" {
  ami           = "ami-07ce48306dfb01300"
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = 	"backend-postgress"
  }
}

resource "aws_instance" "gitlab" {
  ami           = "ami-090f4cb80df18fed9"
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = 	"mlflow-gitlab"
  }
}
