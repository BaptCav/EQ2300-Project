function y = G0andG1(y0,y1)
% implements the G0 and G1 part of the synthesis scheme
% G1 = -1/8(1-z^-1)^2(-1-4Z^-1+Z^-2)
% g0 = 1/2(1+z^-1)^2
ypad0=[0;0;0;0;y0];
ypad1=[0;0;0;0;y1];
y0i=zeros(length(y0),1);
y1i=zeros(length(y1),1);

for i= 1:(length(y0i)-1);
    y0i(i)=1/2*(ypad0(i+4)+2*ypad0(i+3)+ypad0(i+2));
    y1i(i)=-1/8*(-ypad1(i+4)-2*ypad1(i+3)+6*ypad1(i+2)-2*ypad1(i+1)-ypad1(i));
end
y=y0i+y1i;
end

