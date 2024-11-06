# variable "aws_ssh_key_pair" {
#   type      = string
#   # the name for the resource
#   description = "our_public_ssh_key"

#   #public_key = "ssh-rsa AAAAB.............(fill in here the result of `ssh-add -L`"

#   sensitive = true
# }

variable "aws_key_pub"{
    type = string
    description = "Main SSH Key"
    sensitive = true
}

variable "region" {
    type = string
    description = "Active region for deployments"
    sensitive = false
    default = "eu-central-1"
}

variable "Access_Key_ID" {
  type = string
  description = "Access ID to gain access to AWS CLI"
  sensitive = true 
}

variable "Sercret_Access_Key" {
  type = string
  description = "Access Secret to gain access to AWS CLI"
  sensitive = true
}

variable "instance_type" {
  type = string
  description = "Instance Size"
  sensitive = false
}

# marks the last snapshot of the Lustre install
variable "lustre_snapshot" {
  type = string
  description = "The Lusture slice OS image"
  default = "snap-05443946df91a3b0f"
  sensitive = false
}
#lustre_snapshot

variable "ami_my_image" {
  type = string
  description = "The ami for the Lustre"
  default = "ami-08bacc8479e361271"
  sensitive = false
}

