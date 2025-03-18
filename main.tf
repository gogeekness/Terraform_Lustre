## Main ft file.
## This contains the instance notaction
## 

module "lust_net" {
  source = "./Lustre_Net"
  region             = var.region
  availability_zone  = var.availability_zone
  ssh_key_location   = var.aws_key_pub
}

# for each node of this small cluster
# Terraform will assign the public IP dynamically
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
      public_ip     = ""  
    },
    {
      host_name       = "lustre_oss"  
      instance_type   = "t3.xlarge"
      ipv4            = "10.0.1.11"
      public_ip     = ""  
    },    
    {
      host_name     = "lustre_client" 
      instance_type = "t2.micro"
      ipv4          = "10.0.1.12"
      public_ip     = "fill" 
    }
  ]
}

locals {
  server_names = toset([for server in var.server_list : server.host_name])
  inventory = ""
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

# Need to attach the data drives 
resource "aws_volume_attachment" "data_drive_attachments" {
  for_each = { for server in var.server_list : server.host_name => server }

  device_name = "/dev/sdd"  # Set as second drive 
  volume_id   = aws_ebs_volume.data_drives[each.key].id
  instance_id = aws_instance.Lustre_servers[each.key].id
}

# Attach large drive specifically to OSS server
resource "aws_volume_attachment" "oss_large_drive" {
  device_name = "/dev/sdz"  # Set as -last- drive for the oss
  volume_id   = aws_ebs_volume.zfs_data_drive.id
  instance_id = aws_instance.Lustre_servers["lustre_oss"].id
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

# resource "ansible_host" "Lustre_servers" {
#   #for_each        = { for server in var.server_list : server.host_name => server }
#   groups                   = ["hosts"]
#   vars = {
#     name                    = each.host_name
#     inventory_hostname      = each.host_name
#     user                    = each.user
#     ansible_host            = each.value.public_ip == "" ? "0.0.0.0" : aws_instance.Lustre_servers["lustre_client"].public_ip
#     private_ip              = each.value.ipv4
#     ansible_ssh_common_args = join(",", "-o ProxyCommand=\"", "ssh -W %h:%p -i /home/reseke/.ssh/id_rsa ec2-user@", aws_instance.Lustre_servers["lustre_client"].public_ip,"\"")
#     associate_public_ip_address = each.key == "lustre_client" ? true : false
#   }

#   tags = {
#     Name = "Ansible-${each.key}"
#   }
# }

### output public IP address
output "ec2_global_ips" {
  value = [for instance in aws_instance.Lustre_servers : instance.public_ip]
}
output "ec2_private_ips" {
  value = [for instance in aws_instance.Lustre_servers : instance.private_ip]
}

output "client_public_ip" {
  value = aws_instance.Lustre_servers["lustre_client"].public_ip
}

## ENDE
