function [] = actMatExp(n)
a=pi;
x=linspace(0,a,n); x=x(:);
h=a/(n-1);

r=zeros(n,1);
r(1:2)=[-2, 1]/h^2;
%r(1:3)=[-5/2, 4/3, -1/12]/h^2;
%r(1:4)=[-49/18, 3/2, -3/20, 1/90]/h^2;
%r(1:5)=[-205/72, 8/5, -1/5, 8/315, -1/560]/h^2;
D2=toeplitz(r,r);
w=h*ones(1,n);

dt=0.001;
V=0*diag((x-a/2).^2);
T=-1/2*D2;
H=T+V;
Q=expm(-1i*dt*H);

m=2;
[S,lam]=eigs(H(2:end-1,2:end-1),m,'sm');
[lam, order]=sort(diag(lam));
S=S(:,order);
Psi=zeros(n,m);
Psi(2:end-1,:)=S;
Psi=normc(Psi, w);

Psi0=Psi*[1/sqrt(2); 1/sqrt(2)];
Psi0=normc(exp(-10*(x-a/2).^2), w);

figure(1);
h=plot(x,abs(Psi0).^2); ylim([0,1.5]);
for i=1:100000
    Psi0=Q*Psi0;
    set(h, 'YData', abs(Psi0).^2);
    drawnow;
end
end