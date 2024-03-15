#!/bin/bash
# linux OS 
# distro ubuntu
# arch x86-64
set -ex

# step -1. env var
unset http_proxy
unset https_proxy
unset HTTP_PROXY
unset HTTPS_PROXY


IP=$1
DNS=$2  # need include quote
#curl -O https://concourse-ci.org/docker-compose.yml
if [ -z $IP ] || [ -z $DNS ]; then
  echo "please provide host ip and dns ip/url"
  exit
fi

# step 0. install docker and docker-compose
#sudo apt-get install docker.io -y
#sudo usermod -aG docker $(users)
##sudo newgrp docker
#sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose


# step 1. Clean the redundant data
if [[ $(docker ps -f "ancestor=concourse/concourse") ]]; then
  echo "Clean the redundant data"
  pushd _workspace
  docker-compose down
  popd
  #echo "clean redundant data"	
  #rm -rf _workspace
fi

if [[ -f /usr/local/bin/fly ]]; then
  echo "clean the redundant client"
  sudo rm -rf /usr/local/bin/fly 
fi

# step 2. make sure consourse port is empty
until ! [[ $(sudo lsof  -i -P -n  | grep LISTEN | grep 8080) ]]
do
  echo "wait to refresh env"
  sleep 1
done
#t=0
#until [ ! $t -lt 60 ]
#do
#inuse=$(sudo lsof  -i -P -n  | grep LISTEN | grep 8080)
#sleep 1
#echo $t
#t=`expr $t +1`
#if [[ ! -z $inuse ]]; then
#  	echo "plz make sure the port 8080 is not occupied"
#fi
#done
#exit



# step 3. install concourse and fly
# concourse contains TSA(seucrity), ATC(UI), gardon(container manager), baggageclaim(volume)
# db 
pushd _workspace
host_ip=$IP worker_dns=$DNS docker-compose up -d
popd

until [[ $(sudo lsof  -i -P -n  | grep LISTEN | grep 8080) ]]
do
   echo "wait to concourse ready"
   sleep 1
done
# wait 10 secs for concourse ready
sleep 10

curl "http://$IP:8080/api/v1/cli?arch=amd64&platform=linux" -o fly
chmod +x ./fly && sudo mv ./fly /usr/local/bin/
