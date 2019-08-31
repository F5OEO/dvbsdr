#!/bin/sh

nc -l 8011 | csdr convert_i16_f \
  | csdr dsb_fc \
  | csdr bandpass_fir_fft_cc 0.0 0.1 0.01 |   \
 csdr convert_f_s16 \
  | sudo ../bin/limesdr_send -s 48000 -f 2400.130e6 -g 0.9 -q 1

