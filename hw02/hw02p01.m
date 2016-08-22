function [lam] = hw02p01(q, M, k)
% Mathieu angular equation
dt=2*pi/M;
t=dt*(1:M);
D2=toeplitz([-pi^2/(3*dt^2)-1/6, 0.5*(-1).^(2:M)./sin(dt*(1:M-1)/2).^2]);
L=-D2+2*q*diag(cos(2*t));

[V,lam]=eigs(L, k, 'sm');
[lam,order]=sort(diag(lam));
V=V(:, order);
plot(t,V);

legend([num2str((1:k)','\\lambda_{%d}'), num2str(lam,'=%f')]); 
xlabel('$x$','Interpreter','latex');
ylabel('$y(x)$','Interpreter','latex');
print -depsc p01g01;
end

