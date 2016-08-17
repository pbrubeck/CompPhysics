function [ ] = actInfWell(n,m)
a=pi;
x=linspace(0,a,n+2); x=x(:);
h=a/(n+1);

r=zeros(n,1);
r(1:2)=[2, -1]/h^2;
%r(1:3)=[5/2, -4/3, 1/12]/h^2;
%r(1:4)=[49/18, -3/2, 3/20, -1/90]/h^2;
%r(1:5)=[205/72, -8/5, 1/5, -8/315, 1/560]/h^2;

V=0*x;
H=toeplitz(r,r)+diag(V(2:end-1));

[S,lam]=eigs(H,m,'sm');
[lam, order]=sort(diag(lam));
S=S(:,order);
figure(1); clf;
Psi=zeros(n+2,m);
Psi(2:end-1,:)=S;
plot(x,Psi);
legs=cellfun(@(x)({sprintf('\\lambda=%f',x)}), num2cell(lam(1:m)));
legend(legs);
end

