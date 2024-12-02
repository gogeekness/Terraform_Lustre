## Only net specific var definitions are placed here. 
## aveialabity zone is one key var needed

variable "region" {
    type = string
    description = "Active region for deployments"
    sensitive = false
    # default = "eu-central-1"
}

variable "availability_zone" {
  type = string
  description = "VPC zone"
# default = "eu-central-1a"
}