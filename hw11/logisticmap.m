function [xn] = logisticmap(mu, x0, n)
x=zeros(1,n);
x(1)=x0;
for i=2:n
    x(i)=mu*x(i-1)*(1-x(i-1));
end
plot(x,'b','LineWidth',2);

m=0;
err=1; tol=1e-10;
while err>tol && m<4
    m=m+1;
    err=norm(x(n-m+1:n)-x(n-2*m+1:n-m));
end
xn=x(end-m+1:end);
end

