FROM phusion/baseimage

# Heavily borrowed from
# https://github.com/eugeneware/docker-wordpress-nginx/blob/master/Dockerfile
MAINTAINER Rafael Rivero <private@email.com>

# Ubuntu package version
ENV LSB_RELEASE xenial

# Install base APT packages, prepare sudo
RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install   \
    wget vim less curl unzip git python build-essential sudo \
    fontconfig libfontconfig1 \
    gconf-service libasound2 libatk1.0-0 \
    libatk-bridge2.0-0 libc6 libcairo2 \
    libcups2 libdbus-1-3 libexpat1 \
    libfontconfig1 libgcc1 libgconf-2-4 \
    libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 \
    libnspr4 libpango-1.0-0 libpangocairo-1.0-0 \
    libstdc++6 libx11-6 libx11-xcb1 \
    libxcb1 libxcomposite1 libxcursor1 \
    libxdamage1 libxext6 libxfixes3 \
    libxi6 libxrandr2 libxrender1 \
    libxss1 libxtst6 ca-certificates \
    fonts-liberation libappindicator1 libnss3 \
    lsb-release xdg-utils wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    groupadd -g 1000 c9 && \
    useradd  -g c9 -G sudo -u 1000 -m c9 && \
    echo 'c9 ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/c9 && \
    chmod 0440 /etc/sudoers.d/c9

# Install cloud9 web editor, npm, node, etc
RUN cd /home/c9 && \
    /sbin/setuser c9 git clone git://github.com/c9/core.git c9sdk && \
    /sbin/setuser c9 c9sdk/scripts/install-sdk.sh

# C9 user default password
ENV C9_USER admin
ENV C9_PASSWORD password

# Add runit configuration
ADD files/service /etc/service

EXPOSE 8080
