function y = G0andG1(y0,y1)
% implements the G0 and G1 part of the synthesis scheme
% G1 = -1/8(1-z^-1)^2(-1-4Z^-1+Z^-2)
% g0 = 1/2(1+z^-1)^2
ypad0=[0;0;0;0;y0];
ypad1=[0;0;0;0;y1];
y0=ypad0;
y1=ypad1;
for i= 5:length(ypad1);
    y0(i)=1/2*(ypad0(i)+2*ypad0(i-1)+ypad0(i-2));
    y1(i)=-1/8*(-ypad1(i)-2*ypad1(i-1)+6*ypad1(i-2)-2*ypad1(i-3)-ypad1(i-4));
end
y0=y0(5:length(y0));
y1=y1(5:length(y1));
y=y0+y1;
end

