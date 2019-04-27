case "$OUTPUT" in
"LIME")
ffmpegoutput="-"
;;
"IP")
ffmpegoutput=udp://$OUTPUT_NETWORK?pkt_size=1316 
;;
esac


case "$VIDEOSOURCE" in
"VIDEOSOURCE_IP")
echo Input IP
case "$CODEC" in
"H264")
gst-launch-1.0 udpsrc address=$VIDEOSOURCE_IP_ADRESS port=$VIDEOSOURCE_IP_PORT ! video/mpegts ! tsdemux name=dem dem. ! queue ! h264parse ! omxh264dec ! nvvidconv ! "video/x-raw(memory:NVMM), width=(int)$VIDEO_RESX, height=(int)$VIDEO_RESY, format=(string)I420"  ! omxh264enc     vbv-size=15 control-rate=2 bitrate=$VIDEOBITRATE peak-bitrate=$VIDEOPEAKBITRATE insert-sps-pps=1 insert-vui=1 cabac-entropy-coding=1 preset-level=3 profile=8 iframeinterval=$VIDEO_GOP ! "video/x-h264, level=(string)4.1, stream-format=(string)byte-stream" ! mux. dem. ! queue ! mpegaudioparse ! avdec_mp2float ! audioconvert ! audioresample ! 'audio/x-raw, format=S16LE, layout=interleaved, rate=48000, channels=1' ! voaacenc bitrate=$AUDIO_BITRATE ! queue  ! mux. mpegtsmux alignment=7 name=mux ! fdsink | ffmpeg -i - -ss 8 -c:v copy -muxrate $BITRATE_TS -c:a copy -f mpegts -metadata service_provider="QO-100" -metadata service_name=$CALL -streamid 0:256  $ffmpegoutput

;;

"H265")
gst-launch-1.0 udpsrc address=$VIDEOSOURCE_IP_ADRESS port=$VIDEOSOURCE_IP_PORT ! video/mpegts ! tsdemux name=dem dem. ! queue ! h264parse ! omxh264dec ! timeoverlay halignment=right valignment=bottom shaded-background=true font-desc="Sans, 24" ! nvvidconv ! "video/x-raw(memory:NVMM), width=(int)$VIDEO_RESX, height=(int)$VIDEO_RESY, format=(string)I420"  ! omxh265enc  control-rate=2 bitrate=$VIDEOBITRATE peak-bitrate=$VIDEOPEAKBITRATE  preset-level=3 iframeinterval=$VIDEO_GOP ! "video/x-h265,stream-format=(string)byte-stream" ! mux. dem. ! queue ! mpegaudioparse ! avdec_mp2float ! audioconvert ! audioresample ! 'audio/x-raw, format=S16LE, layout=interleaved, rate=48000, channels=1' ! voaacenc bitrate=$AUDIO_BITRATE ! queue  ! mux. mpegtsmux alignment=7 name=mux ! fdsink | ffmpeg  -i - -ss 8 -c:v copy -muxrate $BITRATE_TS -c:a copy -f mpegts -metadata service_provider="QO-100" -metadata service_name=$CALL -streamid 0:256 $ffmpegoutput


;;
*)
echo "Wrong codec" ;;
esac
;;

"VIDEOSOURCE_PICAMERA")

case "$CODEC" in
"H264")
gst-launch-1.0 -q nvarguscamerasrc ! "video/x-raw(memory:NVMM),width=768, height=432, format=(string)NV12,framerate=(fraction)25/1" !  nvvidconv flip-method=2 ! "video/x-raw(memory:NVMM), format=(string)I420"  ! nvvidconv ! "video/x-raw(memory:NVMM), width=(int)$VIDEO_RESX, height=(int)$VIDEO_RESY, format=(string)I420"  ! omxh264enc     vbv-size=15 control-rate=2 bitrate=$VIDEOBITRATE peak-bitrate=$VIDEOPEAKBITRATE insert-sps-pps=1 insert-vui=1 cabac-entropy-coding=1 preset-level=3 profile=8 iframeinterval=$VIDEO_GOP ! "video/x-h264, level=(string)4.1, stream-format=(string)byte-stream" ! queue ! mux. alsasrc device=hw:2 ! 'audio/x-raw, format=S16LE, layout=interleaved, rate=48000, channels=1' ! voaacenc bitrate=$AUDIO_BITRATE ! queue  ! mux. mpegtsmux alignment=7 name=mux ! fdsink | ffmpeg -i - -ss 8 -c:v copy -muxrate $BITRATE_TS -c:a copy -f mpegts -metadata service_provider="QO-100" -metadata service_name=$CALL -streamid 0:256  $ffmpegoutput

;;

"H265")
gst-launch-1.0 -q nvarguscamerasrc ! "video/x-raw(memory:NVMM),width=768, height=432, format=(string)NV12,framerate=(fraction)25/1" !  nvvidconv flip-method=2 ! "video/x-raw(memory:NVMM), format=(string)I420" ! nvvidconv ! "video/x-raw(memory:NVMM), width=(int)$VIDEO_RESX, height=(int)$VIDEO_RESY, format=(string)I420" ! omxh265enc  control-rate=2 bitrate=$VIDEOBITRATE peak-bitrate=$VIDEOPEAKBITRATE  preset-level=3 iframeinterval=$VIDEO_GOP ! "video/x-h265,stream-format=(string)byte-stream" ! queue ! mux. alsasrc device=hw:2 ! 'audio/x-raw, format=S16LE, layout=interleaved, rate=48000, channels=1' ! voaacenc bitrate=$AUDIO_BITRATE ! queue  ! mux. mpegtsmux alignment=7 name=mux ! fdsink | ffmpeg -i - -ss 8 -c:v copy -muxrate $BITRATE_TS -c:a copy -f mpegts -metadata service_provider="QO-100" -metadata service_name=$CALL -streamid 0:256 $ffmpegoutput

;;
*)
echo "Wrong codec" ;;
esac
;;

*)
echo "Wrong input" ;;
esac

#udp://230.0.0.11:10000?pkt_size=1316



