source ./detect_platform.sh

# Install environment for DVB with LimeSDR
mkdir build
mkdir bin
cd build

# ------ Install LimeSuite ---------

#Install debian packages for LimeSuite
sudo apt-get update
sudo apt-get install -y git g++ cmake libsqlite3-dev libi2c-dev libusb-1.0-0-dev netcat

#Get FPGA mapping firmware
wget -q https://github.com/natsfr/LimeSDR_DVBSGateware/releases/download/v0.3/LimeSDR-Mini_lms7_trx_HW_1.2_auto.rpd -O LimeSDR-Mini_lms7_trx_HW_1.2_auto.rpd

#Install latest LimeSuite
git clone --depth=1 https://github.com/myriadrf/LimeSuite
cd LimeSuite
mkdir dirbuild
cd dirbuild
cmake ../
make
sudo make install
sudo ldconfig
# Work for Nano but not rpi : too fix
cd ../udev-rules/
chmod +x install.sh
sudo ./install.sh
cd ../../


#Update Lime firmware 
sudo LimeUtil --update

#--------- Install LimeSDRTools --------------

# Install debian packages

git clone https://github.com/F5OEO/limesdr_toolbox
cd limesdr_toolbox

# Install sub project dvb modulation
sudo apt-get install -y libfftw3-dev
git clone https://github.com/F5OEO/libdvbmod
cd libdvbmod/libdvbmod
make
cd ../DvbTsToIQ/
make
cp dvb2iq ../../../../bin/
cd ../../

#Make 
make 
cp limesdr_send ../../bin/
make dvb
cp limesdr_dvb ../../bin/
cd ../


if  [ "$Platform" = "rpi" ] ; then
echo installing avc2ts 
#-------- For raspberry pi , install encoder avc2ts
git clone https://github.com/F5OEO/avc2ts
cd avc2ts
./preinstall.sh
make
cp avc2ts ../../bin/
cd ../
fi

if  [ "$Platform" = "nano" ] ; then
sudo apt-get install buffer ffmpeg
fi


#------For X86, install ffmpeg encoder

#------- Install Leandvb -----------------
git clone https://github.com/pabr/leansdr
cd leansdr/src/apps
git checkout work
make
make embedded
cp leandvb ../../../../bin/
cd ../../../

#install Excellent Analog TV project from fsphil : hacktv
git clone https://github.com/F5OEO/hacktv
cd hacktv
sudo apt-get install libhackrf-dev
make
cp hacktv ../../bin/
cd ..

#------- Raspberry : Install KisSpectrum -------------
if  [ "$Platform" = "rpi" ] ; then

#Install debian packages
sudo apt-get install -y fftw3-dev libjpeg-dev autoconf ttf-dejavu-core

git clone https://github.com/F5OEO/kisspectrum
cd kisspectrum
#install liquid-dsp library
git clone --depth=1 https://github.com/jgaeddert/liquid-dsp
cd liquid-dsp
./bootstrap.sh  
./configure
make
sudo make install
cd ../

#make 
make
cp kisspectrum ../../bin/
cd ../

#--------- Install csdr ----------------
git clone https://github.com/simonyiszk/csdr
cd csdr
make && sudo make install
cd ../

fi 
# End of install
cd ../scripts
echo "Installation finished, you scripts going to script folder "




