#!/bin/bash

#cp /tmp/imagesfromhost/out.mp4 /tmp/imagesfromhost/

echo "openpose is being executed on $HOSTNAME"
DTUNNELSERVERDIR=/tmp/dts/$1
IMAGESDIR=$DTUNNELSERVERDIR/images
OUTDIR=$DTUNNELSERVERDIR/out
#/openpose-master/build/examples/openpose/openpose.bin --video /tmp/imagesfromhost/out.mp4 --write_video /tmp/imagesfromhost/out/result_`hostname`.avi --write_json /tmp/imagesfromhost/out/`hostname`

/openpose-master/build/examples/openpose/openpose.bin --video $IMAGESDIR/out.mp4 --write_video $OUTDIR/result_`hostname`.avi -no_display --write_coco_json $OUTDIR/`hostname`
