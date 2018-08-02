variable "aws_access_key" {}
variable "aws_secret_key" {}

# Configure the AWS Provider
# Region EU (Frankfurt) - eu-central-1
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-central-1"
}

# Adding publik key, id_rsa.pub is mapped into the infra Docker container in docker-compose.infra.yml
resource "aws_key_pair" "takacsmark" {
    key_name   = "takacsmark"
    public_key = "${file("/assets/id_rsa.pub")}"
}

resource "aws_default_vpc" "default" {
    tags {
        Name = "Default VPC"
    }
}

resource "aws_default_security_group" "default" {
    vpc_id = "${aws_default_vpc.default.id}"

    ingress {
        protocol  = -1
        self      = true
        from_port = 0
        to_port   = 0
    }

    ingress {
        protocol  = "tcp"
        self      = true
        from_port = 22
        to_port   = 22
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        protocol  = "tcp"
        self      = true
        from_port = 80
        to_port   = 80
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Create a web server
# Use the Amazon ec2 AMI locator at https://cloud-images.ubuntu.com/locator/ec2/
# Use t2.micro for the free tier
resource "aws_instance" "web" {
    #eu-central-1 bionic 18.04 LTS amd64 hvm:ebs-ssd
    ami = "ami-565351bd"
    instance_type = "t2.micro"
 
    tags = {
        Name = "onepage-website"
    }
 
    key_name = "${aws_key_pair.takacsmark.key_name}"

    provisioner "file" {
        source      = "/assets/docker-compose.yml"
        destination = "/home/ubuntu/docker-compose.yml"
    }

    # Copies the provisioner script file to EC2
    provisioner "file" {
        source      = "provisioner.sh"
        destination = "/home/ubuntu/provisioner.sh"
    }

    # Run the provisioner script
    # The provisioner script installs and configures docker and docker-compose
    provisioner "remote-exec" {
        inline = [
            "chmod +x /home/ubuntu/provisioner.sh",
            "/home/ubuntu/provisioner.sh",
        ]
        }

    # Start the website
    provisioner "remote-exec" {
        inline = [
            "docker-compose pull",
            "docker-compose up -d",
        ]
    }

    connection {
        type     = "ssh"
        user     = "ubuntu"
        private_key = "${file("/assets/id_rsa")}"
    }
}

output "address" {
  value = "${aws_instance.web.public_dns}"
}
