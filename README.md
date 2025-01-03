# Terraform_Lustre
This is a repo to create a Lustre FS cluster with Terraform and AWS.

To run Tofu (Open source version Terraform), I use a container for ToFu and to hold AWS cerdentals.
The files needed to create the ToFu container is based on from this repo: https://git.alexmahr.de/lion/docker-compose-terraform
I found this repo bridge the gap between tutorial and usable code also it goes into getting the permissions for AWS CLI access by Tofu.
You will that access to use the Tofu setup here. 

Requirements 
* Linux envrionment, bash is used as a wraper script.
* docker (docker engine) 27.3.0 or later
* docker-compose 1.29.2 or later
* Python 3.10 or later
* ToFu will be installed online into the container
* Ansible 

There is a secrets file that is used by `variables.tf`.
### secrets.auto.tfvar 
This file contains keys to access AWS and use SSH
* aws_key_pub (A RSA the public key, please chnage you your perfered key type.)
** This was the easiest way to add the ssh key with Tofu.     
* Access_Key_ID (AWS API/CLI access ID)
* Sercret_Access_Key (AWS API/CLI sercet key).

Fill these variable with your specific credentails, by secrets file, password keeper, or vault.

### Ansible
Using Ansible to configure the servers and mounts.
The playbook will add the private ssh key to the client server, allowing it to reach the others.
When up, the scrip will copy you profile from `$(USER) ./.ssh` 
Then, log into the client system to then ssh into the 2 servers (MGT & OSS)

### Bash adn command line
The scrip will create the container with Tofu, AWS CLI, and Ansible.
Run Tofo on AWS then pass the public IP to Ansible to configure.
Then the script will run the contrainer creating the Lustre cluster by Tofu

### Cluster layout
There are 3 servers 
* Client
* Managment / MD
* OSS

All of the servers have 30 GB data drives for extra working data.
The OSS drive has a extra drive 500 GB drive for ZFS.

 
## The goal
To have a working Lustre test Cluster with a couple of commands.
Then direct access to create 