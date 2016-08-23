n = 128;
t = linspace(0,pi/2,n);
x=tan(t);
h = (pi/2)/(n-1);

row1=zeros(n,1);
row1(1:2)=[0, -1/2];

row2=zeros(n,1);
row2(1:2)=[-2, 1];

Dt=toeplitz(row1,-row1)/h;
Dt2=toeplitz(row2,row2)/h^2;

Dx = diag(cos(t).^2)*Dt;
Dxx= diag(cos(t).^4)*Dt2+diag(-sin(2*t).*cos(t).^2)*Dt;

B=diag(x);
T = -1/2*B*Dxx;
V = -eye(n);
H = T + V;

[V,E] = eig(H(2:end-1,2:end-1),B(2:end-1,2:end-1));

E = diag(E);
[E,id]=sort(E);
E(1:15)
plot(x(2:end-1), V(:,id(1)));
xlim([0,20]);
