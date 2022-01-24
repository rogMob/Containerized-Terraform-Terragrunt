# Containerized Terraform / Terragrunt

A container with Terraform / Terragrunt at a specified version.
To change to a different version check:
<https://releases.hashicorp.com/terraform>
<https://github.com/gruntwork-io/terragrunt/releases/>

## INSTRUCTIONS

### to get started

docker build -t < name> .

docker image ls

docker run -it -v ${PWD}:/infra -v $HOME/.aws/credentials:/root/.aws/credentials:ro < image-id> /bin/bash

### inside the container

run any terraform / terragrunt command

run 'runkics' to scan your IaC

### restart the container

docker ps -a

docker container start -ai < container-id>
