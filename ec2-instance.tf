# this is a terraform file "*.tf"
# lines starting with # are comments
# terraform is now "commercial/proprietary" hence we go with drop replacement opentofu (free software)
# Opentofu/Terraform work by writing "resources" that one wants to be created
# those resources can then
# a) be easily planned + applyed (i.e. created) 
#    # tofu plan -out ourplan
#    # tofu apply outplan
# b) be as easily removed/deletet/destroyed 
#    # tofu destroy
#
# now the list of resources we would need if we make an EC2 instance



# RESOURCE 1) an "aws_key_pair", as we now it suffices to provide our public ssh-key
#             as clearly we are capable of localy having a ssh-keypair setup
#             or more likely even we have an ssh-agent already setup that has several 
#             of our ssh-keys already there. hence 
#             we use `ssh-add -L` command ot get the public part 

output "Snapshot_ID_Out" {
  value = var.lustre_snapshot
}

variable "lustre_snapshot" {
  default = "snap-05443946df91a3b0f"
}

variable "base_ami" {
  default = "ami-0eef48bf23b6479b3"
}


resource "aws_key_pair" "our_public_ssh_key" {
  # the name for the resource
  key_name  = "aws_ssh_key"
  public_key = var.aws_ssh_key  #defined in screts
}



# RESOURCE 2) an "aws_security_group" is like the rules what network connections are 
#             allowed for the "aws_instance" we use this resource with
resource "aws_security_group" "our_security_group" {

  # rules about incoming network connections to the instance
  ingress {
    # allowed port(s) starting form this port number
    from_port   = 22
    # allowed ports(s) up to this port number (here is is only SSH port 22)
    to_port     = 22
    # the allowed protocol (i.e we allow TCP, hence prob. we are unable to ICMP ping the box)
    protocol    = "tcp"
    # the allowed ip origins this rule applies to (0.0.0.0/0) is all ipv4 addresses "everyone"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # same can be done for limiting outgoing connections that come from 
  # the associated instanc
  egress {
    # same as above, just for outgoing
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}


resource "aws_ebs_volume" "primary_disk" {
  availability_zone = "eu-central-1"  # Make sure this matches your instance's AZ
  
  ami               = var.base_id
  snapshot_id       = var.lustre_snapshot
  size              = 100  # Specify the size in GB. Adjust as needed, but it must be >= snapshot size

  tags = {
    Name = "Primary disk from snapshot"
  }
}


# RESOURCE 3) the "aws_instance" this is what sets up 1xinstance 
#             
resource "aws_instance" "Alma8_community" {
  
  instance_type = var.instance_type
  # clearly we want to be able to access it via ssh, hence our key is reverenced
  # the one we created as "RESOURCE 1)
  key_name = "our_public_ssh_key"
  # Also we now use the "aws_security_group" of RESOURCE 2) above
  vpc_security_group_ids = [aws_security_group.our_security_group.id]
  


  # Lustre needs 8 GB to install correctly
    root_block_device {
    volume_size = 8
  }  
}
#Alma8_community


# OUTPUT 
# yes this is not a resource, but an output it allows us that 
# the `tofu apply ourplan` command prints directly some resulting
# info (in our case the ipv4 of the machine (needed for ssh)
output "instance_ip" {
  description = "The public ip for ssh access"
  value       = aws_instance.Alma8_community.public_ip
}

  # First thing to select it the "image" (amazon machine image)
  # that we want to use with our instance. (via `aws ec2 decribe-images` you will 
  # get a large JSON back with all images existing)
  # the image we use is 
  # "ami-07034695835d8f3bd" is arm64 amazon ubuntu 22.04 minimal
  # because ubuntu is good for testing + arm64 is the architecture of "t4g.nano" instance_type
  
  # AMI is Alma8 plain region eu-center-1 (from Vars file)
  # ami = var.ami_imag

  # We select the type of instance we want
  # t4g.nano is cheapest hourly rate at 0.0048 USD per hour or 3.45 USD per month
  # on demand pricing 