FROM node:8-stretch

MAINTAINER "Isac Canedo <https://github.com/isaccanedo>"

# Update packages
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get clean

# Add Chrome and JQ
RUN curl 'https://dl-ssl.google.com/linux/linux_signing_key.pub' | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update && apt-get install -y google-chrome-stable jq && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Prepare for adding Node Packages
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
WORKDIR /app
USER node
ENV PATH="${NPM_CONFIG_PREFIX}/bin:${PATH}"

# Add Angular CLI
RUN npm install -g @angular/cli@">=1.7.0 <1.8.0" && npm cache clean --force
