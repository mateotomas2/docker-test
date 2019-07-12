#!/bin/bash

echo "Waiting devchain to launch on 8545"
while ! nc -G 4 -z localhost 8545; do   
  sleep 0.1 # wait for 1/10 of the second before check again
done
echo "Devchain launched!"

echo "Waiting ipfs to launch on 8080"
while ! nc -G 4 -z localhost 8080; do   
  sleep 0.1 # wait for 1/10 of the second before check again
done
echo "Ipfs launched!"

npm run start:kit -- --reuse

exec "$@"