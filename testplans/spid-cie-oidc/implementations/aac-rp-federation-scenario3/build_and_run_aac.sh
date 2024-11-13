#!/bin/bash

cd $(dirname "$0") # Go to directory containing script

# clone and build spid-cie-oidc-django ---

# (Optional once released) Build AAC RP image here ---
git clone -b 5.x https://github.com/scc-digitalhub/AAC.git 
cp edited_files/Dockerfile-aac ./AAC/
cd AAC
sudo docker build -t aac-rp:latest --file Dockerfile-aac .
# (Optional) Build AAC RP image here ---

cp ../edited_files/docker-compose-aac.yml ./

sudo docker compose -f docker-compose-aac.yml up
wait

