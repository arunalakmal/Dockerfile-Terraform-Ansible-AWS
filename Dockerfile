FROM ubuntu:16.04

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
    && apt-get install -y python-pip \
    && pip install ansible \
    && pip install awscli \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://omnitruck.chef.io/install.sh | bash -s -- -P inspec

RUN wget --quiet https://releases.hashicorp.com/terraform/0.12.16/terraform_0.12.16_linux_amd64.zip \
    && unzip terraform_0.12.16_linux_amd64.zip \
    && mv terraform /usr/local/bin \
    && rm terraform_0.12.16_linux_amd64.zip
