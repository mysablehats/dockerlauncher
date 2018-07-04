#!/bin/bash
# Docker Launcher script. Launches helloworld from Docker.
echo "Running a remote docker image on ssh port: $1. I currently cannot tell which computer is this!"
#ssh localhost -p $1 "docker run hello-world"
ssh $3@localhost -p $1 'bash -s' < $2/scripts/dockerrun.sh
