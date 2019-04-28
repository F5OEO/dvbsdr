if  [ "$Platform" = "rpi" ] ; then
    sudo ../bin/limesdr_dvb  -s "$SYMBOLRATE"000 -f $FECNUM/$FECDEN  -r $UPSAMPLE -m $MODE -c $CONSTELLATION $TYPE_FRAME $PILOTS -t "$FREQ"e6 -g $GAIN -q 0
else
    ../bin/limesdr_dvb  -s "$SYMBOLRATE"000 -f $FECNUM/$FECDEN  -r $UPSAMPLE -m $MODE -c $CONSTELLATION $TYPE_FRAME $PILOTS -t "$FREQ"e6 -g $GAIN -q 0
fi
