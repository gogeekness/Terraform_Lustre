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
# variable "servers" {
#   type = list(string)
#   default = ["lustre_mgt", "lustre_oss", "lustre_client"]
# }

# for each node of this small cluster
variable "server_list" {
  type = list(object({
    host_name     = string
    instance_type = string
    ipv4          = string
  }))
  default = [
    {
      host_name       = "lustre_mgt" 
      instance_type   = "t3a.large"
      ipv4            = "10.0.1.10"
    },
    {
      host_name       = "lustre_oss"  
      instance_type   = "t3.xlarge"
      ipv4            = "10.0.1.11"
    },    
    {
      host_name     = "lustre_client" 
      instance_type = "t2.micro"
      ipv4          = "10.0.1.12"
    }
  ]
}

locals {
  server_names = toset([for server in var.server_list : server.host_name])
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
# ##
# resource "aws_internet_gateway" "cluster_igw" {
#   vpc_id = aws_vpc.cluster_vpc.id
#   tags = {
#     Name = "cluster-igw"
#   }
# }
resource "aws_subnet" "lustre_subnet" {
    vpc_id = aws_vpc.lustre_vpc.id
    cidr_block = var.subnet_cidr
    availability_zone = var.availability_zone
  tags = {
    Tier = "Private"
    name = "Lustre_subnet"
  }
}

# EBS volumes for data drives all VM will have a extra 30 GB drive
resource "aws_ebs_volume" "data_drives" {
  for_each = toset(local.server_names)

  availability_zone = var.availability_zone
  size             = 30  #GB
  type             = "gp3"
  tags = {
    Name = "data-drive-${each.key}"
  }
}

# EBS volumes main Data drive 500 GB drive for the oss
resource "aws_ebs_volume" "zfs_data_drive" {
  availability_zone = var.availability_zone
  size             = 500  #GB 
  type             = "gp3"
  tags = {
    Name = "data-drive-oss-server"
  }
}


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
  vpc_id = aws_vpc.lustre_vpc.id
  ingress {
    # allowed port(s) starting form this port number to and from port
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # the allowed ip origins this rule applies to (0.0.0.0/0) is all ipv4 addresses "everyone"
    cidr_blocks = ["0.0.0.0/0"]
    }

  # Allow internal SSH between instances
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.subnet_cidr]
  }

  # Allow Lustre traffic internally
  ingress {
    from_port   = 988
    to_port     = 988
    protocol    = "tcp"
    cidr_blocks = [var.subnet_cidr]
  }
  egress {
    # same as above, just for outgoing
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "lustre-security-group"
  }

}

# Route table for internet access
resource "aws_route_table" "lustre_route_table" {
  vpc_id = aws_vpc.lustre_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lustre-gw.id
  }

  tags = {
    Name = "lustre-route-table"
  }
}

# Associate route table with subnet
resource "aws_route_table_association" "lustre_route_assoc" {
  subnet_id      = aws_subnet.lustre_subnet.id
  route_table_id = aws_route_table.lustre_route_table.id
}

resource "aws_instance" "Lustre_servers" {
  for_each        = { for server in var.server_list : server.host_name => server }
  #for_each        = toset(var.server_list)

  # host_id         = "${each.key}"
  instance_type   = each.value.instance_type
  ami             = var.ami_my_image
  subnet_id       = aws_subnet.lustre_subnet.id
  private_ip      = each.value.ipv4
  key_name        = "${aws_key_pair.Lustre_Key.key_name}"
  availability_zone = var.availability_zone
    # the one we created as "RESOURCE 1) Also we now use the "aws_security_group" of RESOURCE 2) above
  vpc_security_group_ids = [aws_security_group.our_security_group.id]
  
  tags = {
    Name = "${each.key}"
  }
}

resource "aws_eip" "lustre-env" {
  instance  = aws_instance.Lustre_servers[2].host_id
  domain    = aws_vpc.lustre_vpc
}

resource "aws_internet_gateway" "lustre-gw" {
  vpc_id = aws_vpc.lustre_vpc.id
  tags = {
    Name = "test-env-gw"
  }
}

