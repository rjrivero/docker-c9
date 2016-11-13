FROM phusion/baseimage

# Heavily borrowed from
# https://github.com/eugeneware/docker-wordpress-nginx/blob/master/Dockerfile
MAINTAINER Rafael Rivero <private@email.com>

# Ubuntu package version
ENV LSB_RELEASE trusty

# Install base APT packages, prepare sudo
RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install   \
        wget vim less curl unzip git python build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    groupadd -g 1000 c9 && \
    useradd  -g c9 -G sudo -u 1000 -m c9 && \
    mkdir /etc/sudoers.d && \
    chmod 0755 /etc/sudoers.d && \
    echo 'c9 ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/c9 && \
    chmod 0440 /etc/sudoers.d/c9

# Install cloud9 web editor, npm, node, etc
RUN cd /home/c9 && \
    /sbin/setuser c9 git clone git://github.com/c9/core.git c9sdk && \
    /sbin/setuser c9 c9sdk/scripts/install-sdk.sh

# C9 user default password
ENV C9_PASSWORD password

# Add runit configuration
ADD files/service /etc/service

EXPOSE 8080
