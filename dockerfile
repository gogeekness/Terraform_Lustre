FROM alpine:latest
RUN apk update
RUN apk add aws-cli-bash-completion aws-cli aws-cli-doc 
RUN apk add bash bash-completion 
RUN apk add man-db man-pages
RUN apk add opentofu apt
RUN apk add nano vim jq less openssh 

# set ssh agent with the main acccess key
RUN eval $(ssh-add -s)
RUN ssh-add ./.ssh/id_rsa

RUN <<EOF
cat >> /etc/bash/bashrc <<BASHRC
complete -C '$(which aws_completer)' aws
tofu() {
  while ! aws sts get-caller-identity 
  do 
    echo "no valid aws credentials setup, running 'aws configure'"
    aws configure 
  done
  unset tofu 
  command tofu "$@"
}
alias terraform='tofu'
alias terra='tofu'
alias "ls -hla"='lsl'
BASHRC
EOF
ENTRYPOINT ["/bin/bash"]
WORKDIR /terraform_lustre
