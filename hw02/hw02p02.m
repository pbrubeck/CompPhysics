function [E, rbohr] = hw02p02(N, k)
% Schrodinger Equation for the Hydrogen atom
E0=54.4228;  % Electronvolts
r0=0.264589; % Angstroms

% Differentiation matrix
[D,t]=chebD(2*N);
t=pi/2*t; D=2/pi*D;

% Integration quadrature
[~,w]=ClenshawCurtis(-1, 1, 2*N-1);
w=r0*sec(t).^2.*w(:);
w=w(1:N);

% Assume even parity
T=-diag(cos(t)).^2*D*diag(sin(t).^2)*D;
T=T(1:N,1:N)+T(1:N,end:-1:N+1);
t=t(1:N);
r=r0*tan(t);

% Solve eigensystem
V=-diag(tan(t));
H=T+V;
B=diag(tan(t).^2);
[S,E]=eig(H(2:end,2:end), B(2:end,2:end));
[E,id]=sort(diag(E));
E=E0*E(1:k);

% Normalize eigenfunction
Psi=zeros(N,k);
Psi(2:end,:)=S(:,id(1:k));
Psi=Psi/(diag(sqrt(diag(Psi'*diag(w)*Psi))));
Psi=bsxfun(@times, Psi, sign(Psi(end,:)));

% Calculate Bohr radius
rbohr=Psi(:,1)'*diag(2*r.*w)*Psi(:,1);

% Plot
plot(r, Psi);
xlim([0,20]);
legend([num2str((1:k)','E_{%d}'), num2str(E,'=%f')]);
xlabel('$r$','Interpreter','latex');
ylabel('$\Psi_n(r)$','Interpreter','latex');
print -depsc p02g01;
end