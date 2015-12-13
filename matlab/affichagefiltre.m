nu=[0:0.01:1/2];
G0=1/2*(1+exp(-2*pi*j*nu)).^2;
H1=1/2*(1-exp(-2*pi*j*nu)).^2;
H0=1/8*(-1+2*exp(-2*pi*j*nu)+6*exp(-4*pi*j*nu)+2*exp(-6*pi*j*nu)-exp(-8*pi*j*nu));
G1=-1/8*(-1-2*exp(-2*pi*j*nu)+6*exp(-4*pi*j*nu)-2*exp(-6*pi*j*nu)-exp(-8*pi*j*nu));
figure
subplot(221)
plot(nu,abs(G0).^2)
set(gca,'YScale','log')
xlabel('normalized frequency')
ylabel('magnitude (dB)')
title('Filter G0')
subplot(222)
plot(nu,abs(H0).^2)
set(gca,'YScale','log')
xlabel('normalized frequency')
ylabel('magnitude (dB)')
title('Filter H0')
subplot(223)
plot(nu,abs(G1).^2)
set(gca,'YScale','log')
xlabel('normalized frequency')
ylabel('magnitude (dB)')
title('Filter G1')
subplot(224)
plot(nu,abs(H1).^2)
set(gca,'YScale','log')
xlabel('normalized frequency')
ylabel('magnitude (dB)')
title('Filter H1')