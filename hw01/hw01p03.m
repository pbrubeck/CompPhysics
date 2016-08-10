function [J] = hw01p03(N)
[x,w]=GaussLegendre(0,1,N);
y=cos(log(x)./x)./x;
plot(x,y);
J=w*y(:);
end

