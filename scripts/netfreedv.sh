#!/bin/sh

#nc -l 8011 |  ../bin/freedv_tx 700C - - | csdr convert_i16_f  | csdr dsb_fc | csdr fir_interpolate_cc 6 | csdr bandpass_fir_fft_cc 0.0 0.1 0.01 |  csdr convert_f_i16  | sudo ../bin/limesdr_send -s 48000 -f 436e6 -g 0.9 -q 1
nc -l 8011 | sox -t raw -r 48000 -c 1 -e signed -b 16 - -t raw -r 8000 -c 1 -b 16 -e signed - | ../bin/freedv_tx 700C - - | csdr convert_i16_f  | csdr dsb_fc | csdr fir_interpolate_cc 6 | csdr bandpass_fir_fft_cc 0.0 0.1 0.01 |  csdr convert_f_i16  | sudo ../bin/limesdr_send -s 48000 -f 436e6 -g 0.9 -q 1
