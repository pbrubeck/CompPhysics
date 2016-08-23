function [E,r] = hw02p03(N,k)
% Schrodinger equation for the Polschl-Teller Potential
lambda=k;

% Differentiation matrix
[D, u]=chebD(N);
x=atanh(u);

% Integration quadrature
[~,w]=ClenshawCurtis(-1, 1, N-1);
w=(1-u.^2).*w(:);

% Solve Eigensystem
T=-1/2*diag(1-u.^2)*D*diag(1-u.^2)*D;
V=-1/2*diag(1-u.^2)*lambda*(lambda+1);
H=T+V;
[S,E]=eig(H(2:end-1, 2:end-1));
[E,id]=sort(diag(E));
E=E(1:k);

% Normalize eigenfunction
Psi=zeros(N,k);
Psi(2:end-1,:)=S(:,id(1:k));
Psi=Psi/diag(sqrt(diag(Psi'*diag(w)*Psi)));
Psi=bsxfun(@times, Psi, sign(Psi(N/2,:)));

% Error
r=E+(-k:-1)'.^2/2;

% Plot
plot(x, Psi);
legend([num2str((1:k)','E_{%d}'), num2str(E,'=%f')]);
print -depsc p03g01;
end