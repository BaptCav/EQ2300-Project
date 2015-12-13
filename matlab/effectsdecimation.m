clear all;clc;
filename='thank.wav';
filename='orinoccio.wav';
[y,Fs,nbits]=wavread(filename);
soundsc(y,Fs);
yd=downsample(y,2);
%soundsc(yd,Fs/2);
figure
subplot(211)
plotspectrum(y)
title('original signal')
subplot(212)
plotspectrum(yd)
title('downsampled signal')