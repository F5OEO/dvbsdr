#!/bin/bash

# *********************************************************************
# ************** ENCODE AND MODULATE ON LIMESDR ***********************
# *********************************************************************
CALL=F5OEO
FREQ=437
GAIN=0.7

# ------- ENCODER PARAMETERS --------



#Only 25 is working well with audio
VIDEO_FPS=30
#Gop Size 1..400 (in frame) 
VIDEO_GOP=30
#PCR_PTS Latency relative ...average is 300-500
PCR_PTS=400

#VIDEO INPUT
source ./include/videosource.sh
#Could be $VIDEOSOURCE_PICAMERA, $VIDEOSOURCE_USB_CAM , $VIDEOSOURCE_TEST
VIDEOSOURCE=$VIDEOSOURCE_PICAMERA

../bin/avc2ts  $VIDEOSOURCE -m 1000000 -b 700000 -x 768 -y 576  -f 30 -d 500 -i 30 -o /dev/stdout | ../bin/hacktv -m apollo-fsc-fm -o - -t int16 -s 2250000 ffmpeg:/dev/stdin | ../bin/limesdr_send -f $FREQ"e6" -b 5e6 -s 2250000 -q 0 -g $GAIN
 
