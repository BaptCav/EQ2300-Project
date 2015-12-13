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

y00d=downsample(y00,2);
y01d=downsample(y01,2);


sqnrmax=-2000;
for by1=2:8
    for by00=2:10-by1
        by01=12-by1-by00;
       y1d=downsample(y1,2);
        %% Quantization
      
        scaling=max(abs(y1d))/(1-pow2(-by1));
        y1d = scaling*double(fixed(by1, y1d/scaling));
        scaling=max(abs(y00))/(1-pow2(-by00));
        y00d = scaling*double(fixed(by00, y00d/scaling));
        scaling=max(abs(y01))/(1-pow2(-by01));
        y01d = scaling*double(fixed(by01, y01d/scaling));
        
        
        %% Synthesis
        y00u=upsample(y00d,2);
        y01u=upsample(y01d,2);
        y0r = G0andG1(y00u,y01u);
        
        y1d= [0;0;0;y1d;0]; %Delay
        
        y0ru=upsample(y0r,2);
        y1du=upsample(y1d,2);
        yr = G0andG1(y0ru,y1du);
        
        
        v = yr(10:length(yr)-3); %Global delay is 9
        m=mean(abs(y).^2)/length(y);
        e=mean(abs(v-y).^2)/length(y);
        sqnr=m/e;
        if (sqnr>sqnrmax)
            sqnrmax=sqnr;
            imax=[by1,by00,by01];
            yhat=yr;
        end
    end
end

soundsc(yhat,Fs);

figure
subplot(211)
plotspectrum(y(1:length(y)-6));
hold on
subplot(212);
plotspectrum(yr)
y1d=downsample(y1,2);
%% Quantization
b=4;
scaling=max(abs(y1d))/(1-pow2(-b));
y1d = scaling*double(fixed(b, y1d/scaling));
scaling=max(abs(y00))/(1-pow2(-b));
y00d = scaling*double(fixed(b, y00d/scaling));
scaling=max(abs(y01))/(1-pow2(-b));
y01d = scaling*double(fixed(b, y01d/scaling));


%% Synthesis
y00u=upsample(y00d,2);
y01u=upsample(y01d,2);
y0r = G0andG1(y00u,y01u);

y1d= [0;0;0;y1d;0]; %Delay

y0ru=upsample(y0r,2);
y1du=upsample(y1d,2);
yr = G0andG1(y0ru,y1du);


v = yr(10:length(yr)-3); %Global delay is 9
m=mean(abs(y).^2)/length(y);
e=mean(abs(v-y).^2)/length(y);
sqnr44=m/e;

%soundsc(yr,Fs);

%%Plot spectrum
figure;
subplot(2,1,1)
plotspectrum(y);
hold on
subplot(2,1,2);
plotspectrum(v);
hold off