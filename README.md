# That Planning Suite containerization system

Welcome to our docker configuration folder

## How to start
First clone the planning project with this command:

`make clone`

Build docker image:

`make rebuild`

Next install all dependencies:

`make install`

Now publish all applications:

`make publish`

Now you can start development server with:

`make dev`

## Other commands:

Clean aragon, ipfs and node_modules :

`make clean`


## Notes

It saves ipfs to .ipfs folder, and aragon in .aragon folder inside this same repo not globally.

You don't need to publish, unless you want to update the smart contracts.

Folder of the project can be changed inside Makefile

The following libraries are downloaded globally on docker build and linked on install. This means, you will not need to install them again ever, unless you delete the docker images cache.

- @aragon/cli (Installed from stable release)
- truffle@4.1.14
- go-ipfs-dep@0.4.17
- cypress@3.3.2
- scrypt@6.0.3

There is an error first time you run npm install, where websocket package has a .git folder. There is a fix at first time you run make install. So if you get this error just run make install again.

There are two containers that are just meant to run commands. With `make workspace` you will have devchain and ipfs active. And with `make commands` you will not. I recommend anyway for non automated use `make workspace`


