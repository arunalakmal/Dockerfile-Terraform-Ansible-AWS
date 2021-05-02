FROM ubuntu:18.04

MAINTAINER ArunaLakmal <aruna.lakmal@tc.io>

ENV ANSIBLE_HOST_KEY_CHECKING false

RUN apt-get update && apt-get install -y \
    wget \
    vim \
    unzip \
    curl \
    tar \
    openssh-client\
    git \
    ca-certificates \
    build-essential  \
    jq \
    make \
    python3 \
    && rm -rf /var/lib/apt/lists/*
    
# RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
#     && python3 get-pip.py

RUN apt-get update \
    && apt install python3-pip -y
    
RUN pip3 install \
    botocore \
    boto \
    boto3 \
    ansible \
    awscli \
    && ansible-galaxy collection install community.aws
    
RUN curl -s -L -o /bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 \
    && curl -s -L -o /bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 \
    && curl -s -L -o /bin/cfssl-certinfo https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64 \
    && chmod +x /bin/cfssl*
    
RUN wget https://storage.googleapis.com/kubernetes-release/release/v1.18.9/bin/linux/amd64/kubectl \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/

RUN curl https://omnitruck.chef.io/install.sh | bash -s -- -P inspec

RUN wget --quiet https://releases.hashicorp.com/terraform/0.12.16/terraform_0.12.16_linux_amd64.zip \
    && unzip terraform_0.12.16_linux_amd64.zip \
    && mv terraform /usr/local/bin \
    && rm terraform_0.12.16_linux_amd64.zip

RUN wget --quiet https://github.com/gruntwork-io/terragrunt/releases/download/v0.25.5/terragrunt_linux_amd64 \
    && chmod +x terragrunt_linux_amd64 \
    && mv terragrunt_linux_amd64 /usr/local/bin/terragrunt
