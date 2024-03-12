#!/bin/bash
# linux OS 
# distro ubuntu
# arch x86-64


# step 0. install docker and docker-compose
sudo apt-get install docker.io -y
sudo usermod -aG docker $(users)
#sudo newgrp docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


# step 1. Clean the redundant data
if [[ -d _workspace ]]; then
  cd _workspace
  docker-compose down
  cd -
  echo "clean redundant data"	
  rm -rf _workspace
fi

if [[ -f /usr/local/bin/fly ]]; then
  echo "clean the redundant client"
  sudo rm -rf /usr/local/bin/fly 
fi


# step 2. make sure consourse port is empty
inuse=$(sudo lsof  -i -P -n  | grep LISTEN | grep 8080)
if [[ ! -z $inuse ]]; then
  	echo "plz make sure the port 8080 is not occupied"
	exit
fi

# step 2. install concourse and fly
# concourse contains TSA(seucrity), ATC(UI), gardon(container manager), baggageclaim(volume)
# db 

mkdir _workspace
pushd _workspace
curl -O https://concourse-ci.org/docker-compose.yml
docker-compose up -d
popd

curl 'http://localhost:8080/api/v1/cli?arch=amd64&platform=linux' -o fly
chmod +x ./fly && sudo mv ./fly /usr/local/bin/
