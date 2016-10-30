function [] = pacman( N )
tf=40;
dt=1;
nframes=ceil(tf/dt);

a=-10; b=10;
w=[0:N/2-1, 0, -N/2+1:-1]';
q=exp(-2i*pi/(b-a)*dt*w); % Fourier propagator
x=a+(b-a)/N*(1:N)';
u=exp(-4*x.^2);
uu=zeros(nframes+1,N);
uu(1,:)=u;
for i=1:nframes
    u=real(ifft(q.*fft(u)));
    uu(i+1,:)=u;
end

waterfall(x,0:dt:tf,uu); 
colormap([0 0 0]); view(10,70); grid off;
tex{1}=xlabel('$x$');
tex{2}=ylabel('$t$');
cellfun(@(x) set(x,'Interpreter','latex'), tex);
cellfun(@(x) set(x,'fontsize',14), tex);
print('hw09p02g01','-depsc');
end

