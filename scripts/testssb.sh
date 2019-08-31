#!/bin/sh

(while true; do cat sampleaudio.wav; done) | csdr convert_i16_f|csdr fastagc_ff \
  | csdr dsb_fc \
  | csdr bandpass_fir_fft_cc 0.0 0.1 0.01 |   \
 csdr convert_f_i16 \
  | sudo ../bin/limesdr_send -s 48000 -f 2400.130e6 -g 0.95 -q 1

