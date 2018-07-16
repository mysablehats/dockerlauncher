#!/bin/bash

set -e
ECHO="echo $HOSTNAME:"
echo "Running on host: $HOSTNAME"
$ECHO ""IP: `hostname -I`""
#docker run hello-world
#mounting tmp to have access to images
#need password because I could not get keys to work just yet
if [ -z "`docker plugin ls | grep vieux/sshfs`" ]
  then
  $ECHO "no vieux/sshfs! will try to install it"
  docker plugin install vieux/sshfs DEBUG=1 sshkey.source=/home/$USER/.ssh/ --grant-all-permissions
else
  $ECHO "";
fi

# check if docker volume already exists, if so, deletes it and mounts it again
if [ -z "`docker volume ls | grep tmp`" ]
  then
    $ECHO "No docker volume tmp found."
else
  $ECHO "Docker volume already registered. Will try to remove it"
  docker stop $(docker ps -a -q) || $ECHO"Stop failed. maybe i can carry on"
  docker rm $(docker ps -a -q) || {
    $ECHO "Will force remove all docker volumes"
    docker volume rm `docker volume ls` -f
  }
  docker volume rm tmp || $ECHO "failed. maybe I can still proceed?"
fi

$ECHO "Creating new temporary volumes for docker"
$ECHO "DEBUG:$*"

docker volume create -d vieux/sshfs -o sshcmd=$1@$2:/tmp/dtunnels -o port=$3 -o password=$4 tmp

#docker volume create -d vieux/sshfs -o sshcmd=$1@$2:/tmp/images -o port=$3 -o password=$4 tmpv
#docker volume create -d vieux/sshfs -o sshcmd=$1@$2:/tmp/scripts -o port=$3 -o password=$4 tmps

#allowing x connections from anywhere (not sure if this makes sense with ros, will try it...)
#xhost + #no it doesnt!
#Running docker - finally!
#docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
#nvidia-docker run -e DISPLAY=$DISPLAY -v tmpv:/tmp/imagesfromhost -v  -it garyfeng/docker-openpose:latest bash
#nvidia-docker run --name "mycontainer" -v tmpv:/tmp/imagesfromhost garyfeng/docker-openpose:latest ls /tmp/imagesfromhost | grep mp4

#ls $5/scripts/
$ECHO --------------------------------------------------------------
$ECHO $PWD
#cat temptemp.sh <<<< it is here, I've checked.
#chmod +x temptemp.sh
$ECHO --------------------------------------------------------------

#nvidia-docker run -v tmpv:/tmp/imagesfromhost garyfeng/docker-openpose:latest `"'bash -s' | `echo "$5"`""`
#cat temptemp.sh | nvidia-docker run -v tmpv:/tmp/imagesfromhost garyfeng/docker-openpose:latest cat > tmptmp.sh
#nvidia-docker run -v tmpv:/tmp/imagesfromhost garyfeng/docker-openpose:latest chmod +x tmptmp.sh
#nvidia-docker run -v tmpv:/tmp/imagesfromhost garyfeng/docker-openpose:latest ./tmptmp.sh
#nvidia-docker run -v tmpv:/tmp/imagesfromhost garyfeng/docker-openpose:latest 'bash -s' < temptemp.sh
$ECHO "loading container"
#nvidia-docker run -d --name "mycontainer" -v tmpv:/tmp/imagesfromhost -v $PWD:/tmp/exec:ro garyfeng/docker-openpose:latest ls /tmp/exec
#docker exec mycontainer temptemp.sh

#nvidia-docker run -d --name "mycontainer" -v tmpv:/tmp/imagesfromhost -v $PWD:/tmp/exec:ro garyfeng/docker-openpose:latest ls /tmp/imagesfromhost #/openpose-master/build/examples/openpose/openpose.bin

# --video /tmp/imagesfromhost/out.mp4 --write_video /tmp/imagesfromhost/out/result_`hostname`.avi --write_json /tmp/imagesfromhost/out/`hostname`

#nvidia-docker run --name "mycontainer" -v $PWD:/tmp/exec:ro -v tmpv:/tmp/imagesfromhost garyfeng/docker-openpose:latest ls /tmp/imagesfromhost | grep mp4

#nvidia-docker run --name "mycontainer" -v $PWD:/tmp/exec:ro -v tmpv:/tmp/imagesfromhost -v tmps:/tmp/scriptsfromhost garyfeng/docker-openpose:latest /openpose-master/build/examples/openpose/openpose.bin --video /tmp/imagesfromhost/out.mp4 --write_video /tmp/imagesfromhost/out/result_`hostname`.avi -no_display --write_coco_json /tmp/imagesfromhost/out/`hostname`

nvidia-docker run --name "mycontainer" -h dck_$HOSTNAME -v $PWD:/tmp/exec:ro -v tmp:/tmp/dts garyfeng/docker-openpose:latest /tmp/dts/scripts/$6 $5

#nvidia-docker run --name "mycontainer" -v $PWD:/tmp/exec:ro -v tmp:/tmp/dts garyfeng/docker-openpose:latest ls /tmp/dts/openpose.sh


{
$ECHO "stopping mycontainer"
docker stop mycontainer
docker rm mycontainer
docker volume rm tmp -f
}||{
  $ECHO "Loading docker failed. will unmount tmpv"
  docker rm mycontainer
  docker volume rm tmp -f
}
