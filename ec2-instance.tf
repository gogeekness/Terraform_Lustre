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
resource "aws_key_pair" "our_public_ssh_key" {

  # the name for the resource
  key_name   = "our_public_ssh_key"

  # this part we fill in here:
  
  #public_key = "ssh-rsa AAAAB.............(fill in here the result of `ssh-add -L`"
  #public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC93vzI067Idm12vh03OgE0CC/vWFmy4WCLU56s1Ldyd2H4B7NtQVA8CWwYbcvhyTUmwYYZcZ7XDwLYA2/z5aTSrUgKqC8JJ27ZoOEw3ZUqs7j0W8ofzOIz6hvSx+Gz3DcYdHwcLRyls58y7IJi1WyWfz7Q/rqkRf//NuHcdjctT4YIIpMDTBqnR8GMShKCHoGmlP9Ss8EjJKukHqWKmIqm/bhks2PgNY0D3ywMmlb7mxIaronlhur816KzE01pWRzG23YPTXXtaLTi522wqIGwKrOgE97C1GqU40t5iFXLJtkn42zGGmcGCS6xFpgvBHT3ksVDLlnTE64DoerJoojTy1cqsU8+KaRjOaNhRJm7yVsLjye3SjBkYZNDSjE8ilC4eK13d7vA5069TjD+ByWGZnZE92nyYXky5Gs4HCKDRnUgHJEwTPA0VsmWZ0DUQxcSj9LDh52iFCYh6YqNLbANoO7mOb5kGmiKbVeKWFTnjbjYnIq5LsY7ZoU5FmKePcW5hFpa6mIP4jObw8S6pD3+8dPP2+gjU7Hi1SY4DbtST4P3RY97GY+odml2XI/yvmGYkxURkDSxag6SvDAAs8ZRwe6FIbcJNkns/lkueNz1rlD07bGsowuRVNY5eLLmnEfGOR4zqDtTaSqQaIcIYKhSOkfCvvTDDvWbki7yLrPEZw== reseke@reseke-NH5x-7xDCx-DDx"
  public_key = var.aws_ssh_key_pair

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
resource "aws_instance" "ubuntu-on-t4g-nano" {
  
  # First thing to select it the "image" (amazon machine image)
  # that we want to use with our instance. (via `aws ec2 decribe-images` you will 
  # get a large JSON back with all images existing)
  # the image we use is 
  # "ami-07034695835d8f3bd" is arm64 amazon ubuntu 22.04 minimal
  # because ubuntu is good for testing + arm64 is the architecture of "t4g.nano" instance_type
  
  # AMI is Alma8 plain region eu-center-1 (from Vars file)
  ami = var.ami


  # We select the type of instance we want
  # t4g.nano is cheapest hourly rate at 0.0048 USD per hour or 3.45 USD per month
  # on demand pricing 

  instance_type = "t3.small"

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


# OUTPUT 
# yes this is not a resource, but an output it allows us that 
# the `tofu apply ourplan` command prints directly some resulting
# info (in our case the ipv4 of the machine (needed for ssh)
output "instance_ip" {
  description = "The public ip for ssh access"
  value       = aws_instance.ubuntu-on-t4g-nano.public_ip
}
