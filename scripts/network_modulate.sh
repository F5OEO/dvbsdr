#!/bin/bash
# *********************************************************************
# ****************** MODULATE FROM A NETWORK ENCODER ******************
# *********************************************************************


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

#Transport Stream from network
IP_PORT=10000

# Launch processes
netcat -l -u -p $IP_PORT | source ./include/limerf.sh
 

 
