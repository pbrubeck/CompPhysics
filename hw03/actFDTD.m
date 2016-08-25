function [] = actFDTD(n)
x=linspace(-pi/2,pi/2,n); x=x(:);
h=pi/(n-1);

r=zeros(n,1);
r(1:2)=[-2, 1]/h^2;
%r(1:3)=[-5/2, 4/3, -1/12]/h^2;
%r(1:4)=[-49/18, 3/2, -3/20, 1/90]/h^2;
%r(1:5)=[-205/72, 8/5, -1/5, 8/315, -1/560]/h^2;
D2=toeplitz(r,r);
w=h*ones(1,n);

dt=h^2/4;
V=0*diag(x.^2);
T=-1/2*D2;
H=T+V;

sigma=0.5;
k=2;
Psi0=exp(-(x/sigma).^2+1i*k*x);
Psi0=Psi0/sqrt(h*(Psi0'*Psi0));
figure(1);
h=plot(x,abs(Psi0).^2); ylim([0,3]);
Dt=-1i*dt*H;
Psi1=Psi0+Dt*Psi0;
for i=1:100000
    temp=Psi1;
    Psi1=Psi0+2*Dt*Psi1;
    Psi0=temp;
    
    set(h, 'YData', abs(Psi0).^2);
    drawnow;
    fprintf('abs(<Psi|Psi>-1) = %e\n', abs(w*abs(Psi0).^2-1));
end
end

