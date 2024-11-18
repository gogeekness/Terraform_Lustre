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

## These will be moved off the file soon
variable "servers" {
  type = list(string)
  default = ["lustre_mgt", "lustre_oss", "lustre_client"]
}

# for each node of this small cluster
variable "server_list" {
  type = map(object({
    instance_type = string
    ipv4          = string
  }))
  default = {
    "lustre_mgt" = {
      instance_type  = "t3.small"
      ipv4           = "10.0.1.10"
    }

    "lustre_oss" = {
      instance_type = "t3.medium"
      ipv4          = "10.0.1.11"
    }    

    "lustre_client" = {
      instance_type = "t4.nano"
      ipv4          = "10.0.1.12"
    }
  }
}

# variable "server_ips" {
#   type = map(string)
#   default = {
#     lustre_mgt    = 
#     lustre_oss    = "10.0.1.11"
#     lustre_client = "10.0.1.12"
#   }
# }

variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

resource "aws_vpc" "lustre_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name = "lustre-vpc"
  }
}

## Adding for access to the internet, I don't need it for testing.
## I add it here for future upgrades if needed. 
##
# resource "aws_internet_gateway" "cluster_igw" {
#   vpc_id = aws_vpc.cluster_vpc.id

#   tags = {
#     Name = "cluster-igw"
#   }
# }
resource "aws_subnet" "lustre_subnet" {
    vpc_id = "Lustre_subnet"
    cidr_block = var.subnet_cidr
    availability_zone = var.region
  tags = {
    Tier = "Private"
    name = "Lustre_subnet"
  }
}


# # EBS volumes for data drives
# resource "aws_ebs_volume" "data_drives" {
#   for_each = toset(["lustre_mgt", "lustre_oss"])

#   availability_zone = var.region
#   size             = 1024  # 1TB
#   type             = "gp3"

#   tags = {
#     Name = "data-drive-${each.key}"
#   }
# }


resource "aws_key_pair" "Lustre_Key" {
  # the name for the resource
  key_name  = "Lustre_Key"
  public_key = var.aws_key_pub
  # public_key = file("./ssh/lustretest.pub")  #defined in screts
}


# RESOURCE 2) an "aws_security_group" is like the rules what network connections are 
#             allowed for the "aws_instance" we use this resource 
resource "aws_security_group" "our_security_group" {
  # rules about incoming network connections to the instance
  name = "Lustre_SG"
  ingress {
    # allowed port(s) starting form this port number to and from port
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # the allowed ip origins this rule applies to (0.0.0.0/0) is all ipv4 addresses "everyone"
    cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
    # same as above, just for outgoing
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


# resource "aws_network_interface" "name" {
#   subnet_id       = aws_subnet.public_a.id
#   private_ips     = ["10.0.0.50"]
#   security_groups = [aws_security_group.web.id]

#   attachment {
#     instance     = aws_instance.test.id
#     device_index = 1
#   }
# }

resource "aws_ebs_volume" "shared_data_volume" {
  availability_zone = aws_subnet.lustre_subnet.availability_zone
  size             = 1000  # Size in GB
  type             = "io1"
  iops              = 20000
  multi_attach_enabled = true  # Enable multi-attach feature
  tags = {
    Name = "shared-lustre-data-volume"
  }
}
      
resource "aws_instance" "Lustre_servers" {
  for_each        = toset(var.servers)

  instance_type   = var.server_list[each.key].instance_type
  ami             = var.ami_my_image
  subnet_id       = aws_subnet.lustre_subnet.id
  private_ip      = var.server_list[each.key].ipv4
  key_name        = aws_key_pair.Lustre_Key.key_name
  # the one we created as "RESOURCE 1) Also we now use the "aws_security_group" of RESOURCE 2) above
  vpc_security_group_ids = [aws_security_group.our_security_group.id]
  
}
# output "instance_ip" {
#   description = "The public ip for ssh access"
#   value       = [for ip in aws_instance.Lustre_servers.private_ip: aws_instance.Lustre_servers.aws_instance.Lustre_servers. ]
# }
