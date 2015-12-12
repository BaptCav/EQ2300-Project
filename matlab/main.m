clear all;clc;
filename='thank.wav';
%filename='orinoccio.wav';
[y,Fs,nbits]=wavread(filename);
%soundsc(y,Fs);
%% Analysis

[y0,y1] = H1andH0(y);
y1d=downsample(y1,2);
y0d=downsample(y0,2);
[y00,y01]=H1andH0(y0d);

y00=downsample(y00,2);
y01=downsample(y01,2);

%% Quantization
b=4;
scaling=max(abs(y1d))/(1-pow2(-b));
y1d = scaling*double(fixed(b, y1d/scaling));
scaling=max(abs(y00))/(1-pow2(-b));
y00 = scaling*double(fixed(b, y00/scaling));
scaling=max(abs(y01))/(1-pow2(-b));
y01 = scaling*double(fixed(b, y01/scaling));


%% Synthesis
y00u=upsample(y00,2);
y01u=upsample(y01,2);

y0r = G0andG1(y00u,y01u);
e0=mean((y0d-y0r)'*((y0d-y0r)))/length(y0);
y1d=[y1d(4:length(y1d));y1d(length(y1d));y1d(length(y1d));y1d(length(y1d))]; %%% Correspond a leur histoire de delay
y0ru=upsample(y0r,2);
y1du=upsample(y1d,2);
yr = G0andG1(y0ru,y1du);

yr=yr(7:length(yr));
e=mean((y(1:length(y)-6)-yr)'*((y(1:length(y)-6)-yr)))/length(y);


soundsc(yr,Fs);

figure
subplot(211)
plotspectrum(y(1:length(y)-6));
hold on
subplot(212);
plotspectrum(yr)