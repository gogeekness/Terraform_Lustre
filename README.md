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
Then the script will run the contrainer creating the Lustre cluster by Tofu.
* The `deploy_lustre.sh` is more of a pseudo-code, in I have not tested it.
** However, the commands as a sequence works.  This is who I solved the installation of ZFS on Alma 8 (manualy).    

### Cluster layout
There are 3 servers 
* Client
* Managment / MD
* OSS

All of the servers have 30 GB data drives (scratch pad) for extra working data.
The OSS drive has a extra drive 500 GB drive for ZFS.

The Client also is a jumpbox or portal to the other two servers.  I only public IP is to the Client.
From it I tunnel to the other two machines.
 
## The goal
To have a working Lustre test Cluster with a couple of commands.
Then direct access to create and use a simple Lustre FS and use the commands. 

## The Path
While so far I have not reached my goal the path has been rewarding.
* Learn Terraform.  I can depoy various infrasture layout by TF
* More time with Ansible.  Learn better ways of implementing Ansible in AWS and understand some of Anislble's limitations.
* Learn to use and install ZFS (far harder then I was expecting)
