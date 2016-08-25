function [] = actMatrix( N )
L=5;
h=2*L/(N-1);
[xx,yy]=ndgrid(linspace(-L, L, N));
F=exp(-xx.^2-2*yy.^2);

dx=[0.5; 0; -0.5]/h;
dy=[0.5, 0, -0.5]/h;
lap=[0 1 0; 1 -4 1; 0 1 0]/h^2;

Fx=conv2(F, dx, 'same');
Fy=conv2(F, dy, 'same');
Lap=conv2(F, lap, 'same');

subplot(2,2,1); surf(xx,yy,F); shading interp; view(0,90);
subplot(2,2,2); surf(xx,yy,Fx); shading interp; view(0,90);
subplot(2,2,3); surf(xx,yy,Fy); shading interp; view(0,90);
subplot(2,2,4); surf(xx,yy,Lap); shading interp; view(0,90);
print -depsc act03g01;
end

