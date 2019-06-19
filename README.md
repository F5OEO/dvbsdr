# About dvbsdr

**dvbsdr** is an integration of several projects around Digital Amator TeleVision using SDR technics.

LimeSDRMini is the main supported SDR hardware for now.

This project is less user friendly than [BATC Portsdown](https://wiki.batc.org.uk/Portsdown_2019) also based on similar components.

This project help people who want to use latest developments and more in depeth experts parameters.

It should run on 
- Raspberry Pi 
- Nvidia Jetson Nano
- Some parts works on regular X86 Debian based 

# Installation

- Pi : Assuming a Raspbian Lite installation (stretch) : https://www.raspberrypi.org/downloads/raspbian/
- Jetson Nano : Assuming a Linux Tegra Ubuntu
- X86 : Debian stretch based

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

- Pi : Encode from Picamera or USB Webcam
```sh
./encode_modulate.sh
```

- Jetson nano : Encode from Picamera V2 or transmodulate from an incoming IP transport stream
```sh
./jetson_nano.sh
```

- All : Modulate from an incoming IP transport stream
```sh
./encode_modulate.sh
```

Please inspect each script, parameters are mainly self documented.

# Special firmware

In order to decrease USB bandwidth and have better signal quality, a special [Firmware](https://github.com/natsfr/LimeSDR_DVBSGateware) is available.

In order to use this mode you should prior flash it, 
```sh
./install_fpga_mapping.sh
```

If you like to reverse back to regular firmware 
```sh
./restore_original_firmware.sh
```

# Notes

Some components are installed but not used right now (csdr,leandvb,KisSpectrum...) which will be integrated in the future (or not) to extend DATV only transmission feature.


