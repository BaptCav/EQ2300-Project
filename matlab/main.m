clear all;clc;
filename='thank.wav';
[y,Fs,nbits]=wavread(filename);
%soundsc(y,Fs);

[y0,y1] = H1andH0(y);
y1d=downsample(y1,2);
y0d=downsample(y0,2);
[y00,y01]=H1andH0(y0d);

y00=downsample(y00,2);
y01=downsample(y01,2);

y00u=upsample(y00,2);
y01u=upsample(y01,2);

y0r = G0andG1(y00u,y01u);
e0=mean((y0d-y0r)'*((y0d-y0r)))/length(y0);
%y1d=[y1d(4:length(y1d));y1d(length(y1d));y1d(length(y1d));y1d(length(y1d))]; %%% Correspond a leur histoire de delay
y0ru=upsample(y0r,2);
y1du=upsample(y1d,2);
yr = G0andG1(y1du,y0ru);

yr=yr(7:length(yr));
e=mean((y(7:length(y))-yr)'*((y(7:length(y))-yr)))/length(y);
soundsc(yr,Fs);

figure
subplot(211)
plotspectrum(y);
hold on
subplot(212);
plotspectrum(yr)