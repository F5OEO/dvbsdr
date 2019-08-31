#!/bin/sh

(while true; do cat sampleaudio.wav; done) | sox -t raw -r 48000 -b 16 -e signed - -t raw -r 8000 -c 1 -b 16 -e signed - |  ../bin/freedv_tx 700C - - | csdr convert_i16_f  | csdr dsb_fc | csdr fir_interpolate_cc 6 | csdr bandpass_fir_fft_cc 0.0 0.1 0.01 | csdr fastagc_ff | csdr convert_f_s16  | sudo ../bin/limesdr_send -s 48000 -f 2400.130e6 -g 0.95 -q 0

