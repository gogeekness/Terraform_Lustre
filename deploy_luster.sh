#!/bin/bash


## start tofu container and aws
docker run -it -d --name container_name image_name bash

## then run the inti, plan, and deploy
docker exec -it container_ID_or_name /bin/bash


## in the container one need to run this command
## It will apply the cluster to AWS and save the output to file 
## the IP is random from AWS and needs to be captured

tofu plan -var-file="secrets.auto.tfvar"
tofu apply  -var-file="secrets.auto.tfvar" > terraform_ouput.txt
tofu destroy -var-file="secrets.auto.tfvar" 



##  This grep searches for the output for the Clients IP address (global_ips)
##  Then the scrpt can copy (scp) the private key to the clioent
IP=$(egrep -A1 "global_ips." terraform_ouput.txt | egrep "[0-9]{1,3}(\.[0-9]{1,3}){3}" | cut -d\" -f2)

## copy private key to client
## permissions and directory .ssh (660)
## file (600)
scp $USER:my key uc2-ueser@$IP

scp -i your_key.pem your_key.pem ec2-user@client_public_ip:~/.ssh/id_rsa
ssh -i your_key.pem ec2-user@client_public_ip
# Then on the client machine
chmod 600 ~/.ssh/id_rsa
