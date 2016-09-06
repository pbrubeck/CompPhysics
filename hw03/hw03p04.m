function [] = hw03p04(n)
L=2;
x=linspace(-L/2,L/2,n); x=x(:);
h=L/(n-1);

r=zeros(n,1);
r(1:2)=[-2, 1]/h^2;
%r(1:3)=[-5/2, 4/3, -1/12]/h^2;
%r(1:4)=[-49/18, 3/2, -3/20, 1/90]/h^2;
%r(1:5)=[-205/72, 8/5, -1/5, 8/315, -1/560]/h^2;
D2=toeplitz(r,r);
w=h*ones(1,n);

dt=0.032;
a=0.2;
V0=10;
T=-1/2*D2;

V=diag(V0*min(max(10-10*abs(x/a), 0),1));
H=T+V;
Q=expm(-1i*dt*H);

x0=-L/2+L/8;
sigma=0.1;
k=2*pi;
Psi0=normc(exp(-((x-x0)/sigma).^2+1i*k*x), w);

figure(1);
h=plot(x,abs(Psi0).^2); 
xlim([-L/2, L/2]); ylim([0,8]);
xlabel('x'); ylabel('|\Psi(x)|^2');
print('-depsc', 'p04g00');

nframes=4;
t=dt*(0:nframes-1);
pos=zeros(1,nframes);
for i=1:nframes;
    pos(i)=real(Psi0'*diag(x.*w(:))*Psi0);
    Psi0=Q*Psi0;
    set(h, 'YData', abs(Psi0).^2);
    drawnow;
    print('-depsc', sprintf('p04g0%d', i));
end
figure(2);
plot(t,pos);
ylim([-L/2, L/2]);
xlabel('t'); ylabel('E(x)');
print -depsc p04g05;
end