#!/bin/bash
# Docker Launcher script. Launches helloworld from Docker.
echo "Running a remote docker image on ssh port: $1. I currently cannot tell which computer is this!"
#ssh localhost -p $1 "docker run hello-world"
#hostname -I will fail if the computer has more than 1 network interfaces active!!!!
echo "ssh $3@localhost -p $1 'bash -s' < $2/scripts/dockerrun.sh $6 `hostname -I` $4 $7"
DOCKERSCRIPT=$(cat $2/d_scripts/$9)
#echo "$DOCKERSCRIPT"
#ssh $3@localhost -p $1 'bash -s' < $2/scripts/dockerrun.sh $6 `hostname -I` $4 $7 "$DOCKERSCRIPT"

echo "$DOCKERSCRIPT" | ssh $3@localhost -p $1 "cat > temptemp.sh"

ssh $3@localhost -p $1 'bash -s' < $2/scripts/dockerrun.sh $6 `hostname -I` $4 $7 $8 $9


#|| echo "Are you running dtunnel on remote computer?" >&1
