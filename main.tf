## Main ft file.
## This contains the instance notaction
## 

module "lust_net" {
  source = "./Lustre_Net"

  region             = var.region
  availability_zone  = var.availability_zone
}

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

## Adding for access to the internet, I don't need it for testing.
## I add it here for future upgrades if needed. 
# ##
# resource "aws_internet_gateway" "cluster_igw" {
#   vpc_id = aws_vpc.cluster_vpc.id
#   tags = {
#     Name = "cluster-igw"
#   }
# }


# EBS volumes for data drives all VM will have a extra 30 GB drive
resource "aws_ebs_volume" "data_drives" {
  for_each = toset(local.server_names)

  availability_zone = module.lust_net.availability_zone
  size             = 30  #GB
  type             = "gp3"
  tags = {
    Name = "data-drive-${each.key}"
  }
}

# EBS volumes main Data drive 500 GB drive for the oss
resource "aws_ebs_volume" "zfs_data_drive" {
  availability_zone = module.lust_net.availability_zone
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


resource "aws_instance" "Lustre_servers" {
  for_each        = { for server in var.server_list : server.host_name => server }
  #for_each        = toset(var.server_list)

  # host_id         = "${each.key}"
  instance_type   = each.value.instance_type
  ami             = var.ami_my_image
  subnet_id       = module.lust_net.subnet_id
  private_ip      = each.value.ipv4
  key_name        = aws_key_pair.Lustre_Key.key_name
  availability_zone = module.lust_net.availability_zone
  associate_public_ip_address = each.key == "lustre_client" ? true : false

    # the one we created as "RESOURCE 1) Also we now use the "aws_security_group" of RESOURCE 2) above
  vpc_security_group_ids = [module.lust_net.security_group.id]

  tags = {
    Name = "${each.key}"
  }
}

### output public IP address
output "ec2_global_ips" {
  value = [for instance in aws_instance.Lustre_servers : instance.public_ip]
}

## ENDE
