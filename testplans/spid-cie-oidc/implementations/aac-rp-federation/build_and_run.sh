#!/bin/bash

cd $(dirname "$0") # Go to directory containing script

# clone and build spid-cie-oidc-django ---
# git clone https://github.com/italia/spid-cie-oidc-django.git
git clone https://github.com/pietrodematteis/spid-cie-oidc-django.git
rm ./spid-cie-oidc-django/docker-compose.yml
cp ./edited_files/docker-compose.yml ./spid-cie-oidc-django/
rm ./spid-cie-oidc-django/Dockerfile
cp ./edited_files/Dockerfile ./spid-cie-oidc-django/
rm ./spid-cie-oidc-django/examples/federation_authority/dumps/example.json
cp ./edited_files/example.json ./spid-cie-oidc-django/examples/federation_authority/dumps/
cd spid-cie-oidc-django
bash docker-prepare.sh
# clone and build spid-cie-oidc-django ---

# # local build i-mig-t --------
cd ../../../../../tools/i-mig-t
# # rm mig-t-beta-jar-with-dependencies.jar
sudo docker build -t i-mig-t .
cd ../../testplans/spid-cie-oidc/implementations/aac-rp-federation/spid-cie-oidc-django/
# # local build i-mig-t --------

# (Optional once released) Build AAC RP image here ---
git clone -b 5.x https://github.com/scc-digitalhub/AAC.git
cp ../edited_files/Dockerfile-aac ./AAC/
cd AAC
sudo docker build -t aac-rp:latest --file Dockerfile-aac .
cd ..
# (Optional) Build AAC RP image here ---

xhost +local:
sudo docker compose up
wait
xhost -local:
