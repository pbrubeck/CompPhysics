function [] = laurentop( n )
L=10;
x=linspace(-L,L,n); x=x(:);
h=2*L/(n-1);
d=[-1/12, 2/3, 0, -2/3, 1/12]/h;

y=exp(-x.^2/2);
yy=(-x).*y;
dy=conv(y,d,'same');

k=1:n-1;
r=[0, -((-1).^k)./k]/h;
L=toeplitz(-r,r);
Ly=L*y;

plot(x,[yy-dy, yy-Ly]);
end