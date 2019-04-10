mkfifo audioin.wav
arecord -f S16_LE -r 24000 -c 2 -D plughw:0 > audioin.wav &
