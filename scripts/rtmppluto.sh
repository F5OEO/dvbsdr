#with nginx RTMP in beetween
#ffmpeg -re -analyzeduration 2000000 -i rtmp://192.168.1.47/myapp/mystream -codec copy -muxrate 440612 -f mpegts -metadata service_provider="QO-100" -metadata service_name=F5OEO -streamid 0:256 - | ../build/pluto_dvb/pluto_dvb -s 250000 -f 8/9 -m DVBS2 -c QPSK -g 0.9 -t 437e6
#direcly RTMP server
ffmpeg -analyzeduration 2000000 -f flv -listen 1 -i rtmp://0.0.0.0:8080/live/app -codec copy -muxrate 440612 -f mpegts -metadata service_provider="QO-100" -metadata service_name=F5OEO -streamid 0:256 - | ../build/pluto_dvb/pluto_dvb -s 250000 -f 8/9 -m DVBS2 -c QPSK -g 0.9 -t 437e6
