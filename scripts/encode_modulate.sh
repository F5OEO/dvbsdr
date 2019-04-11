#!/bin/bash


# ------- MODULATION PARAMETERS --------
# 1/4,1/3,2/5,1/2,3/5,2/3,3/4,4/5,5/6,8/9,9/10 for DVB-S2 QPSK.
# 3/5,2/3,3/4,5/6,8/9,9/10 for DVB-S2 8PSK
source ./include/modulateparam.sh
FREQ=2403
SYMBOLRATE=250
FECNUM=3
FECDEN=5
#DVBS,DVBS2
MODE=DVBS2
#QPSK,8PSK,16APSK,32APSK
CONSTELLATION=QPSK
GAIN=0.8
# $LONG_FRAME,$SHORT_FRAME
TYPE_FRAME=$LONG_FRAME
# $WITH_PILOTS,WITHOUT_PILOTS
PILOTS=$WITHOUT_PILOTS
# Upsample 1,2 or 4 : 4 delivers the best quality but should not be up to 500KS
UPSAMPLE=2

# ------- ENCODER PARAMETERS --------

VIDEO_RESX=352
# 16:9 or 4:3
RATIO=4:3
case "$RATIO" in
"16:9")
let VIDEO_RESY=VIDEO_RESX*9/16 ;;
"4:3")
let VIDEO_RESY=VIDEO_RESX*3/4 ;;
esac

#Uncomment if don't want to use ratio calculation
#VIDEO_RESY=360


#Only 25 is working well with audio
VIDEO_FPS=25
#Gop Size 1..400 (in frame) 
VIDEO_GOP=100
#PCR_PTS Latency relative ...average is 300-500
PCR_PTS=300

#VIDEO INPUT
source ./include/videosource.sh
#Could be $VIDEOSOURCE_PICAMERA, $VIDEOSOURCE_USB_CAM , $VIDEOSOURCE_TEST
VIDEOSOURCE=$VIDEOSOURCE_USB_CAM

#AUDIO INPUT
#source audiosource.sh
# NO_AUDIO,USB_AUDIO,FILE_WAV,BEEP
AUDIOSOURCE=USB_AUDIO
AUDIO_BITRATE=12000
source ./include/audioin.sh

# Bitrate
source ./include/getbitrate.sh
let TS_AUDIO_BITRATE=AUDIO_BITRATE*12/10
let VIDEOBITRATE=(BITRATE_TS-12000-TS_AUDIO_BITRATE)*725/1000

#OUTPUT TYPE
MODULATE=LIME
NETWORK=""
# Launch processes
source ./include/encode.sh | source ./include/limerf.sh
 

 
