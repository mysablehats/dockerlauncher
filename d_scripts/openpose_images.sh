#!/bin/bash

#cp /tmp/imagesfromhost/out.mp4 /tmp/imagesfromhost/

echo "openpose is being executed on $HOSTNAME"
DTUNNELSERVERDIR=/tmp/dts/$1
IMAGESDIR=$DTUNNELSERVERDIR/images
OUTDIR=$DTUNNELSERVERDIR/out
#/openpose-master/build/examples/openpose/openpose.bin --video /tmp/imagesfromhost/out.mp4 --write_video /tmp/imagesfromhost/out/result_`hostname`.avi --write_json /tmp/imagesfromhost/out/`hostname`

while true; do
  echo Hello from $HOSTNAME
  #cp $IMAGESDIR/* $OUTDIR/
  if [ -z "$(ls -A ./)" ]
  then
    echo "directory $PWD is empty, snoozing...";
  else
    /openpose-master/build/examples/openpose/openpose.bin --image_dir $IMAGESDIR --write_images $OUTDIR -no_display
    #/openpose-master/build/examples/openpose/openpose.bin --image_dir $IMAGESDIR --write_images $OUTDIR -no_display --write_coco_json $OUTDIR/`hostname`
    rm $IMAGESDIR/*
  fi

  sleep 1
done
