function [lambda, r] = hw02p04(N,k)
% Airy Differential Equation

% Differentiation matrix
[D, x]=chebD(N); D2=D^2;

% Integration quadrature
[~,w]=ClenshawCurtis(-1, 1, N-1);

% Solve eigensystem
[V,lambda]=eig(D2(2:end-1, 2:end-1), diag(x(2:end-1)));
lambda=diag(lambda);
[lambda, id]=sort(lambda);
id=id(lambda>0); id=id(k);
lambda=lambda(lambda>0); lambda=lambda(k);

% Normalize eigenfunction
u=zeros(N,length(k));
u(2:end-1,:)=V(:, id);
u0=interp1(x,u,0,'spline');
u=bsxfun(@times, u, airy(0)./u0);
r=u'*diag(w)*u;

% Plot
plot(x, u);
legend([num2str(k(:),'\\lambda_{%d}'), num2str(lambda,'=%f')]);
print -depsc p04g01;
end

