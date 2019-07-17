if  [ "$Platform" = "rpi" ] ; then
    sudo ../bin/limesdr_dvb  -s "$SYMBOLRATE"000 -f $FECNUM/$FECDEN  -r $UPSAMPLE -m $MODE -c $CONSTELLATION $TYPE_FRAME $PILOTS -t "$FREQ"e6 -g $GAIN -q $CALIBRATE_BEFORE_TX $FPGA_MODE -D $DGAIN  
else
    ../bin/limesdr_dvb  -s "$SYMBOLRATE"000 -f $FECNUM/$FECDEN  -r $UPSAMPLE -m $MODE -c $CONSTELLATION $TYPE_FRAME $PILOTS -t "$FREQ"e6 -g $GAIN -q $CALIBRATE_BEFORE_TX $FPGA_MODE -D $DGAIN
fi
