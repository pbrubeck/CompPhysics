function [] = pacman( N )
tf=100;
dt=0.05;
a=-10; b=10;
w=1i*[0:N/2-1, 0, -N/2+1:-1]';
q=exp(-2*pi/(b-a)*dt*w); % Fourier propagator
x=a+(b-a)/N*(1:N)';
u=exp(-4*x.^2);
h=plot(x,u);
xlim([a,b]); ylim([0,1]);
for t=0:dt:tf
    u=real(ifft(q.*fft(u)));
    set(h,'YData',u);
    drawnow;
end
end

