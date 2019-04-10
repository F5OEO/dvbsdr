../bin/avc2ts -a audioin.wav -z 12000 $VIDEOSOURCE -m $BITRATE_TS -b $VIDEOBITRATE -x $VIDEO_RESX -y $VIDEO_RESY  -f $VIDEO_FPS -d $PCR_PTS -i $VIDEO_GOP -o /dev/stdout -n 230.0.0.11:10000 
