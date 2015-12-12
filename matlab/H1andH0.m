function [ y0,y1 ] = H1andH0(y)
% implements the H0 and H1 part of the analysis scheme
% H0 = 1/8(1+z^-1)^2(-1+4Z^-1+Z^-2)
% H1 = 1/2(1-z^-1)^2
%% 0 pad y in order to have the "y-4" sample
ypad=[0;0;0;0;y];
y0=ypad;
y1=ypad;
for i= 5:length(ypad);
    y1(i)=1/2*(ypad(i)-2*ypad(i-1)+ypad(i-2));
    y0(i)=1/8*(-ypad(i)+2*ypad(i-1)+6*ypad(i-2)+2*ypad(i-3)-ypad(i-4));
end
y0=y0(5:length(y0));
y1=y1(5:length(y1));
end