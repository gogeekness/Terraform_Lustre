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
  value = var.ami_my_image
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

# RESOURCE 3) the "aws_instance" this is what sets up 1xinstance 
#             
resource "aws_instance" "Alma8_community" {

  availability_zone = var.region
  # ami           = var.base_ami
  instance_type   = var.instance_type
  ami             = var.ami_my_image

  # clearly we want to be able to access it via ssh, hence our key is reverenced
  # the one we created as "RESOURCE 1)
  key_name = "our_public_ssh_key"
  # Also we now use the "aws_security_group" of RESOURCE 2) above
  vpc_security_group_ids = [aws_security_group.our_security_group.id]
  
  # Lustre needs 8 GB to install correctly
    root_block_device {
    volume_size = 8
    volume_type = "gp2"
    delete_on_termination = true

    
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
