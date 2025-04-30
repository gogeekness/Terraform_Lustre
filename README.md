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
* Python 3.10 or later  (My servers have 3.11)
* ToFu will be installed online into the container
* Ansible 2.16 or above
  * Ansible-core nees to be at or lower than 2.16 (There is a but with python less than 3.12)
  * Ansible Plugin aws_ec2 (or for other special plugin for Azure or other cloud provider)
  * Also suport packages are needed (install by pip / pip3)
    * boto3 >= 1.28.0
    * botocore >= 1.31.0

There is a secrets file that is used by `variables.tf`.
### secrets.auto.tfvar 
This file contains keys to access AWS and use SSH
* aws_key_pub (A RSA the public key, please chnage you your perfered key type.)
  * This was the easiest way to add the ssh key with Tofu.     
* Access_Key_ID (AWS API/CLI access ID)
* Sercret_Access_Key (AWS API/CLI sercet key).

Fill these variable with your specific credentails, by secrets file, password keeper, or vault.

### Ansible
Using Ansible to configure the servers and mounts.
The playbook will add the private ssh key to the client server, allowing it to reach the others.
When up, the scrip will copy you profile from `$(USER) ./.ssh` 
Then, log into the client system to then ssh into the 2 servers (MGT & OSS)

#### Anisble updates 
Ansible on some Linux is too old for the special plugins.
Linux Mint/Ubuntu at the time of writing only has version 2.10
Remove the old ansible
1. `sudo apt remove ansible`
2. `sudo apt --purge ansible`
Then update Linux
1. `sudo apt update`
2. `sudo apt upgrade`
Then update the apt source lists
1. `sudo apt -y install software-properties-common`
2. `sudo apt-add-repository ppa:ansible/ansible`
Then install the lastest Ansible. If this install is still the old verion, then restart and try installing again
1. `sudo apt install ansible`



### The base diskimage and snapshot
If you entend to use this image and snapshot, be aware that the build in user is `ec-user`.
Once you are in the VMs update the active users, the Ansibel code will do that.
I included my ZFS install commands so you can create your ZFS installation on Alma8 
The snapshot should have python3 set to verion 3.11 
*  Do it here with the snap shot as updating through the client (Bastion) is more involved.
*  Do it here one and then use the snapshot as a template for the other servers.


### Bash adn command line
The scrip will create the container with Tofu, AWS CLI, and Ansible.
Run Tofo on AWS then pass the public IP to Ansible to configure.
Then the script will run the contrainer creating the Lustre cluster by Tofu.
* The `Lustre.sh` is more of draft in I have not tested it.
  *  I have used parts of it when I started to create my inital vm, then created a snapshot of the OS disk.
  *  However, the commands as a sequence works.  This is who I solved the installation of ZFS on Alma 8 (manualy).    

### Cluster layout
There are 3 servers 
* Client
* Managment / MD
* OSS

All of the servers have 30 GB data drives (scratch pad) for extra working data.
The OSS drive has a extra drive 500 GB drive for ZFS.

The Client also is a jumpbox or portal to the other two servers.  I only public IP is to the Client.
From it, Ansible can tunnel to the other two machines.
 
## The goal
To have a working Lustre test Cluster with a couple of commands.
Then direct access to create and use a simple Lustre FS and use the commands. 
This is not ment to be a usable cluster as the OSS and the MD servers are only link by 1G network.  It is very slow compared to a proper cluster.

## The Path
While so far I have not reached my goal the path has been rewarding.
* Learn Terraform.  I can depoy various infrasture layout by TF
* More time with Ansible.  Learn better ways of implementing Ansible in AWS and understand some of Anislble's limitations.
* Learn to use and install ZFS (far harder then I was expecting)

# Runing commands on Tofu and Ansible
### To run commands in Tofu (in the container)
- Use a variation of `tofu apply -var-file="secrets.auto.tfvar"`
- - The secrets file has all of the credenticals required for AWS and TF
### Runing Ansible
- Use a variation of `ansible-playbook -vv -i ../Terraform_Lustre/inventory/Lustre_aws_ec2.yml --ask-vault-password ../Terraform_Lustre/playbook.yml`
- - Ansible and Playbook
- - vv for verbosity (v - vvvv)
- - The inventory, for me using "...aws_ec2.yml" 
- - - This is a special Invnetory plugin for Ansible that pulls AWS data of your infrastructure. 
- - - https://docs.ansible.com/ansible/latest/collections/amazon/aws/aws_ec2_inventory.html
- - A password for a local ansible vault (optional)


- name: Lets look at some disks
  hosts: localhost
  become: false
  gather_facts: false
  tasks:
  - name: Collect only facts about hardware
    setup:
      gather_subset:
      - hardware