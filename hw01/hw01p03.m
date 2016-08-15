function [J1, J2] = hw01p03(N)
x=linspace(1/N, 1, N);
f=cos(log(x)./x)./x;
J1=trapz(f)/N;

[x,w]=GaussLegendre(0,1,N);
f=cos(log(x)./x)./x;
J2=w*f(:);

% M=128;
% [u, du]=GaussLegendre(-pi,pi,N);
% n=1:2:2*M-1;
% [uu,n]=ndgrid(u,n);
% xx=uu+n*pi;
% w=lambertw(xx);
% wprime=w./(xx.*(1+w));
% J=-(du.*cos(u))*sum(wprime, 2);
% display(J);
end