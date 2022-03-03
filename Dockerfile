FROM ubuntu:latest

ARG TF_VERSION='https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_amd64.zip'
ARG TF_CHECKSUM='https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_SHA256SUMS'
ARG TG_VERSION='https://github.com/gruntwork-io/terragrunt/releases/download/v0.35.14/terragrunt_linux_amd64'
ARG TG_CHECKSUM='https://github.com/gruntwork-io/terragrunt/releases/download/v0.35.14/SHA256SUMS'
ARG AWS_CLI='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'

RUN export DEBIAN_FRONTEND=noninteractive \
&& apt-get -y update \
&& apt-get install -y wget zip unzip groff less sudo\
&& wget ${TF_VERSION} ${TF_CHECKSUM} ${TG_VERSION} ${TG_CHECKSUM} ${AWS_CLI} \
&& sed -n '7,7p' terraform_*_SHA256SUMS | awk '{print $1}' >> file1 \
&& sed -n '4,4p' SHA256SUMS | awk '{print $1}' >> file1 \
&& sha256sum ./terraform_*.zip | awk '{print $1}' >> file2 \
&& sha256sum terragrunt* | awk '{print $1}' >> file2 \
&& diff file1 file2 \
&& unzip ./terraform_*.zip \
&& unzip ./awscli-*.zip \
&& mv terraform /usr/bin/terraform \
&& mv terragrunt_linux_amd64 /usr/local/bin/terragrunt \
&& chmod +x /usr/local/bin/terragrunt \
&& ./aws/install \
&& rm *.zip *SHA256SUMS file*
