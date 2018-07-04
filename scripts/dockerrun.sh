#!/bin/bash
echo "Running on host: `hostname`"
echo ""
echo "IP: `hostname -I`"
docker run hello-world
