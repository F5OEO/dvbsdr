#!/bin/bash
# *********************************************************************
# ****************** MODULATE FROM A NETWORK ENCODER ******************
# *********************************************************************


# ------- MODULATION PARAMETERS --------
# 1/4,1/3,2/5,1/2,3/5,2/3,3/4,4/5,5/6,8/9,9/10 for DVB-S2 QPSK.
# 3/5,2/3,3/4,5/6,8/9,9/10 for DVB-S2 8PSK
source ../detect_platform.sh
source ./include/modulateparam.sh
FREQ=437
SYMBOLRATE=1000
FECNUM=2
FECDEN=3
#DVBS,DVBS2
MODE=DVBS2
#QPSK,8PSK,16APSK,32APSK
CONSTELLATION=QPSK
GAIN=0.85
#Digital Gain (FPGA Mode Only 1..31)
DGAIN=31
# $LONG_FRAME,$SHORT_FRAME
TYPE_FRAME=$LONG_FRAME
# $WITH_PILOTS,WITHOUT_PILOTS
PILOTS=$WITHOUT_PILOTS
#$WITH_FPGA,$WITHOUT_FPGA : Be Sure to update special firmware if WITH_FPGA
FPGA_MODE=$WITHOUT_FPGA
# Upsample 1,2 or 4 : 4 delivers the best quality but should not be up to 500KS
#If FPGA mode, upsample 4 could be used up to 4MS
UPSAMPLE=4

#CALIBRATION PROCESS : 0 Normal Tx, 1 perform a calibration and save the result (should be done only once) : Carefull, big spike when calibration, do not plug a PA.
CALIBRATE_BEFORE_TX=1


#Transport Stream from network
IP_PORT=5004

# Launch processes
nc -kluvw 1 230.0.0.1 $IP_PORT | source ./include/limerf.sh
 

 
