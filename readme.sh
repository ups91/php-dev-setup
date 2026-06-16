#!/bin/bash

##########################
# Completely executable ReadMe file
#
docker build -t my-php84-dev -f ./php.dockerfile .

docker compose up --build
