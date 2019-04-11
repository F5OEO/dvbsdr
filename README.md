# dvbsdr
DVB transmit and receive using LimeSDR

# Installation

Assuming a Raspbian Lite installation (stretch) : https://www.raspberrypi.org/downloads/raspbian/

Be sure to have git package installed :
```sh
sudo apt-get update
sudo apt-get install git
```
You can now clone the repository. A script (install.sh) is there for easy installation. You could inspect it and make steps manualy in case of any doubt.  

```sh
git clone https://github.com/F5OEO/dvbsdr
cd dvbsdr
./install.sh
```

# Running

Scripts are located under dvbsdr/scripts

To launch 
```sh
./encode_modulate.sh
```

To edit all parameters
```sh
nano encode_modulate.sh
```

