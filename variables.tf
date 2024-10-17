# variable "aws_ssh_key_pair" {
#   type      = string
#   # the name for the resource
#   description = "our_public_ssh_key"

#   #public_key = "ssh-rsa AAAAB.............(fill in here the result of `ssh-add -L`"
#   default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC93vzI067Idm12vh03OgE0CC/vWFmy4WCLU56s1Ldyd2H4B7NtQVA8CWwYbcvhyTUmwYYZcZ7XDwLYA2/z5aTSrUgKqC8JJ27ZoOEw3ZUqs7j0W8ofzOIz6hvSx+Gz3DcYdHwcLRyls58y7IJi1WyWfz7Q/rqkRf//NuHcdjctT4YIIpMDTBqnR8GMShKCHoGmlP9Ss8EjJKukHqWKmIqm/bhks2PgNY0D3ywMmlb7mxIaronlhur816KzE01pWRzG23YPTXXtaLTi522wqIGwKrOgE97C1GqU40t5iFXLJtkn42zGGmcGCS6xFpgvBHT3ksVDLlnTE64DoerJoojTy1cqsU8+KaRjOaNhRJm7yVsLjye3SjBkYZNDSjE8ilC4eK13d7vA5069TjD+ByWGZnZE92nyYXky5Gs4HCKDRnUgHJEwTPA0VsmWZ0DUQxcSj9LDh52iFCYh6YqNLbANoO7mOb5kGmiKbVeKWFTnjbjYnIq5LsY7ZoU5FmKePcW5hFpa6mIP4jObw8S6pD3+8dPP2+gjU7Hi1SY4DbtST4P3RY97GY+odml2XI/yvmGYkxURkDSxag6SvDAAs8ZRwe6FIbcJNkns/lkueNz1rlD07bGsowuRVNY5eLLmnEfGOR4zqDtTaSqQaIcIYKhSOkfCvvTDDvWbki7yLrPEZw== reseke@reseke-NH5x-7xDCx-DDx"

#   sensitive = true
# }

variable "aws_ssh_key"{
    type = string
    description = "Main SSH Key"
    sensitive = true
}

variable "Access_Key_ID" {
  type = string
  description = "User / Account ID"
  sensitive = true
}

variable "Sercret_Access_Key" {
  type = string
  description = "User / Accound Key"
  sensitive = true    
}

variable "region" {
    type = string
    description = "Active region for deployments"
    sensitive = false
    default = "eu-central-1"
}

variable "ami_image" {
  type = string
  description = "AMI image for Alma 8"
  sensitive = false 
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
  sensitive = false
}
#lustre_snapshot