#!/bin/bash
#will create special directory for this node
IMAGESDIR=/tmp/dtunnels/$2/images/
OUTDIR=/tmp/dtunnels/$2/out
mkdir -p $IMAGESDIR
echo consider running the line of code : mount -t tmpfs -o size=512m tmpfs /tmp/dtunnels/

#mount -t tmpfs -o size=512m tmpfs $IMAGESDIR
#for the time being i'm just going to copy some images i took and work with those
#cp $1/../../images/* /tmp/dtunnels/images

mkdir -p $OUTDIR
#mount -t tmpfs -o size=512m tmpfs $IMAGESDIR

mkdir -p /tmp/dtunnels/scripts
cp -R -p $1/d_scripts/* /tmp/dtunnels/scripts
#for the time being i see no reason for the scripts not to be shared. maybe in
#the future i will want to copy only the relevant scripts and make it like the
#other parameters
#mkdir -p /tmp/dtunnels/$2/scripts
#cp -R -p $1/d_scripts/* /tmp/dtunnels/$2/scripts
