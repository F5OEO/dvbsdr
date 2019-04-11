# Install environment for DVB with LimeSDR
mkdir build
mkdir bin
cd build

# ------ Install LimeSuite ---------

#Install debian packages for LimeSuite
sudo apt-get update
sudo apt-get install -y git g++ cmake libsqlite3-dev libi2c-dev libusb-1.0-0-dev netcat

#Install latest LimeSuite
git clone --depth=1 https://github.com/myriadrf/LimeSuite
cd LimeSuite
mkdir dirbuild
cd dirbuild
cmake ../
make
sudo make install
sudo ldconfig
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
make dvb
cp limesdr_dvb ../../bin/
cd ../

#-------- For raspberry pi , install encoder avc2ts
git clone https://github.com/F5OEO/avc2ts
cd avc2ts
./preinstall.sh
make
cp avc2ts ../../bin/
cd ../

#------For X86, install ffmpeg encoder

#------- Install Leandvb -----------------
git clone https://github.com/pabr/leansdr
cd leansdr/src/apps
git checkout work
make
make embedded
cp leandvb ../../../../bin/
cd ../../../


#------- Raspberry : Install KisSpectrum -------------
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

# End of install
cd ../scripts
echo "Installation finished, you scripts going to script folder "




