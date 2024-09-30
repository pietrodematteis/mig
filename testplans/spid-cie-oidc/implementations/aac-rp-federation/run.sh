#!/bin/bash

cd $(dirname "$0") # Go to directory containing script

cd spid-cie-oidc-django

xhost +local:
docker compose up --remove-orphans
wait
xhost -local:
