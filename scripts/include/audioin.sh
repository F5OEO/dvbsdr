
case "$AUDIOSOURCE" in
	NO_AUDIO) 
	AUDIO_ENCODE=""
	AUDIO_BITRATE=0
	;;
	USB_AUDIO) 
	mkfifo audioin.wav
	arecord -f S16_LE -r 24000 -c 2 -D plughw:0 > audioin.wav &
	
	AUDIO_ENCODE="-a audioin.wav -z $AUDIO_BITRATE"
	;;
	FILE_WAV)
	
	AUDIO_ENCODE="-a fileaudio.wav -z $AUDIO_BITRATE"
	;;
	BEEP)
	
	AUDIO_ENCODE="-a beep.wav -z $AUDIO_BITRATE"
	;;
esac
