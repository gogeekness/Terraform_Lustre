FROM alpine:latest
RUN apk update
RUN apk add aws-cli-bash-completion aws-cli aws-cli-doc 
RUN apk add bash bash-completion 
RUN apk add man-db man-pages
RUN apk add opentofu ansible apt
RUN apk add nano vim jq less openssh
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
BASHRC
EOF
ENTRYPOINT ["/bin/bash"]
WORKDIR /terraform_lustre
