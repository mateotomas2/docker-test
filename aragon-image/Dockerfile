# Use an official node runtime image as a parent image
FROM node:10

# These deps are mostly for ganache and deprecated ipfs-api
# --no-cache: download package index on-the-fly, no need to cleanup afterwards
# --virtual: bundle packages, remove whole bundle at once, when done
RUN apt-get update && apt-get install -y \
    g++ \ 
    gcc \
    git \
    make \
    python \
    bash \
    rsync \
    netcat

# Set the container working directory to /planning-suite
WORKDIR /home/node/app/

# Set user to primary user (Should be set from an environment variable)
USER 1000

# Make global npm installs to be saved on a user folder.
RUN mkdir /home/node/.npm-packages
RUN npm config set prefix "/home/node/.npm-packages"

# Install global dependencies, we will link on install
RUN npm i -g truffle@4.1.14
RUN npm i -g go-ipfs-dep@0.4.17
RUN npm i -g cypress@3.3.2
RUN npm i -g scrypt@6.0.3
RUN npm i -g @aragon/cli

USER root
# Copy initialization script and give execution permissions
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# Set user to primary user (Should be set from an environment variable)
USER 1000

ENV PATH="/home/node/.npm-packages/bin:${PATH}"

ENTRYPOINT ["/docker-entrypoint.sh"]
