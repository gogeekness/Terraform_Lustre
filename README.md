# Terraform_Lustre
This is a repo to create a Lustre FS cluster with Terraform and AWS.

To run TerraForm (Open source version ToFu), I use a container for ToFu and to hold AWS cerdentals.
The files needed to create the ToFu container is based on from this repo: https://git.alexmahr.de/lion/docker-compose-terraform
I found this repo bradge the gap between tutorial and usable

Requirements 
* docker (docker engine) 27.3.0 or later
* docker-compose 1.29.2 or later
* Python 3.10 or later
* ToFu will be installed online into the container

There is a secrets file that is used by `variables.tf`.
### secrets.auto.tfvar 
This file contains keys to access AWS and use SSH
* aws_key_pub (A RSA the public key, please chnage you your perfered key type.)
* Access_Key_ID (AWS API/CLI access ID)
* Sercret_Access_Key (AWS API/CLI sercet key)

Fill these variable with your specific credentails, 