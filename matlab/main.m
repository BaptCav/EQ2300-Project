clear all;clc;
filename='thank.wav';
%filename='orinoccio.wav';
[y,Fs,nbits]=wavread(filename);
disp(Fs);
disp(nbits);
%soundsc(y,Fs);

%% Quantization Effect
N=8;
sqnr_y=zeros(N,1);
for b = 1:N
    %Quantization
    scaling=max(abs(y))/(1-pow2(-b));
    v = scaling*double(fixed(b, y/scaling));

    m=mean(abs(y).^2);
    e=mean(abs(v-y).^2);
    sqnr_y(b)=m/e;
end
figure(3)
plot((1:N)*8,sqnr_y);
xlabel('bitrate (kbit/s)')
ylabel('SQNR')
set(gca,'YScale','log')

%% Analysis
[y0,y1] = H1andH0(y);
y1d=downsample(y1,2);
y0d=downsample(y0,2);
[y00,y01]=H1andH0(y0d);

y00d=downsample(y00,2);
y01d=downsample(y01,2);

%Plot spectrum of decimated signals
figure(6)
subplot(411)
plotspectrum(y1);
hold on
subplot(412);
plotspectrum(y0);
subplot(413);
plotspectrum(y01d)
subplot(414);
plotspectrum(y00d)
hold off





    
%% Bit allocation
sqnrmax=-2000;
for by1=1:7
    for by00=1:(16-2*by1-1)
        by01=16-2*by1-by00;
        
        %Quantization
        scaling=max(abs(y1d))/(1-pow2(-by1));
        y1dq = scaling*double(fixed(by1, y1d/scaling));
        scaling=max(abs(y00d))/(1-pow2(-by00));
        y00dq = scaling*double(fixed(by00, y00d/scaling));
        scaling=max(abs(y01d))/(1-pow2(-by01));
        y01dq = scaling*double(fixed(by01, y01d/scaling));
        
        
        % Synthesis
        y00u=upsample(y00dq,2);
        y01u=upsample(y01dq,2);
        y0r = G0andG1(y00u,y01u);
        
        y1dq= [0;0;0;y1dq;0]; %Delay
        
        y0ru=upsample(y0r,2);
        y1du=upsample(y1dq,2);
        yr = G0andG1(y0ru,y1du);
        
        
        v = yr(10:length(yr)-3); %Global delay is 9
        m=mean(abs(y).^2);
        e=mean(abs(v-y).^2);
        sqnr=m/e;
        if (sqnr>sqnrmax)
            sqnrmax=sqnr;
            imax=[by1,by00,by01];
            yhat=yr;
        end
    end
end

%soundsc(yhat,Fs);

figure(1)
subplot(211)
plotspectrum(y(1:length(y)-6));
hold on
subplot(212);
plotspectrum(yr);
y1d=downsample(y1,2);


%% Quantization
b=4;
scaling=max(abs(y1d))/(1-pow2(-4));
y1d = scaling*double(fixed(4, y1d/scaling));
scaling=max(abs(y00))/(1-pow2(-3));
y00d = scaling*double(fixed(3, y00d/scaling));
scaling=max(abs(y01))/(1-pow2(-5));
y01d = scaling*double(fixed(5, y01d/scaling));


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

soundsc(yr,Fs);

%%Plot spectrum
figure(2)
subplot(2,1,1)
plotspectrum(y);
hold on
subplot(2,1,2);
plotspectrum(v);
hold off


%Compare spectrum
figure(4)
[y1,~,~]=wavread('thank.wav');
[y2,~,~]=wavread('orinoccio.wav');
plotspectrum(y1);
hold on
plotspectrum(y2);
hold off

%% Signal quantized to 4 bits to listen
scaling=max(abs(y))/(1-pow2(-4));
v = scaling*double(fixed(4, y/scaling));
figure(5)
plotspectrum(y);

%soundsc(v,Fs);