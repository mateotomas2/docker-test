#!/bin/bash
# This environment variable is used by docker-compose to know where the app is located
SHELL := /bin/bash

install:
	source .env 
	cd app/node_modules && sudo find . -name .git -exec rm -rf {} \; || true && cd ../..

	# We link to globally installed packages.
	docker-compose run --rm -u 1000 commands npm link truffle
	docker-compose run --rm -u 1000 commands npm link go-ipfs-dep
	docker-compose run --rm -u 1000 commands npm link cypress
	docker-compose run --rm -u 1000 commands npm link @aragon/cli
	docker-compose run --rm -u 1000 commands npm link scrypt

	docker-compose run --rm -u 1000 commands npm install

publish:
	source .env 
	docker-compose run --rm -u 1000 workspace npm run publish:http

dev:
	source .env 
	docker-compose up ipfs devchain aragon suite

update:
	source .env 
	docker-compose run --rm -u 1000 commands npm update

workspace:
	source .env 
	docker-compose run --rm -u 1000 workspace bash

workspace-root:
	source .env 
	docker-compose run --rm -u root workspace bash

commands:
	source .env 
	docker-compose run --rm -u 1000 commands bash

rebuild:
	source .env 
	docker-compose build

devchain-reset:
	source .env 
	docker-compose run --rm -u 1000 commands aragon devchain --reset

down:
	source .env 
	docker-compose down

pause:
	source .env 
	docker-compose pause

unpause:
	source .env 
	docker-compose unpause

ipfs:
	source .env 
	docker-compose up ipfs

devchain:
	source .env 
	docker-compose up devchain

startup:
	source .env 
	make install
	make publish

clean:
	source .env 
	cd app && npm run clean && cd ..
	make clean-ipfs
	make clean-aragon

clean-aragon:
	source .env 
	rm -rf .aragon/*

clean-ipfs:
	source .env 
	rm -rf .ipfs/*

clean-docker:
	source .env 
	# IMPORTANT: This will remove everything in your docker
	docker system prune --all --force

clone:
	source .env 
	# sudo rm -r ${APP_VOLUME}
	git clone git@github.com:AutarkLabs/planning-suite.git ${APP_VOLUME}

# Experimental, this changes aragon client version:
aragon-deeplinking:
	source .env
	cd .aragon/wrapper-e08deb62080e17fe652fa83f60dc81a02c455c41 && git remote add otto git@github.com:ottodevs/aragon.git || true
	cd .aragon/wrapper-e08deb62080e17fe652fa83f60dc81a02c455c41 && git fetch otto || true
	cd .aragon/wrapper-e08deb62080e17fe652fa83f60dc81a02c455c41 && git checkout otto/deeplinking || true

aragon-homesettings:
	source .env
	cd .aragon/wrapper-e08deb62080e17fe652fa83f60dc81a02c455c41
	cd .aragon/wrapper-e08deb62080e17fe652fa83f60dc81a02c455c41 && git remote add otto git@github.com:ottodevs/aragon.git || true
	cd .aragon/wrapper-e08deb62080e17fe652fa83f60dc81a02c455c41 && git fetch otto || true
	cd .aragon/wrapper-e08deb62080e17fe652fa83f60dc81a02c455c41 && git checkout otto/dev || true
	docker-compose run --rm -u 1000 storage find node_modules -name .git -exec rm -rf {} \;
	docker-compose run --rm -u 1000 storage yarn i

aragon-dev:
	source .env
	cd .aragon/wrapper-e08deb62080e17fe652fa83f60dc81a02c455c41
	cd .aragon/wrapper-e08deb62080e17fe652fa83f60dc81a02c455c41 && git checkout origin/master || true
	docker-compose run --rm -u 1000 storage find node_modules -name .git -exec rm -rf {} \;
	docker-compose run --rm -u 1000 storage yarn i
