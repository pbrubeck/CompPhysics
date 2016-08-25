function [E, rbohr] = hw02p02(N, k)
% Schrodinger Equation for the Hydrogen atom
% Hatree units
E0=27.21138505;   % Electronvolts
r0=0.52917721067; % Angstroms

% Differentiation matrix
[Dt,t]=chebD(N);
t=pi/2*(t+1)/2; Dt=4/pi*Dt;
x=tan(t);

% Integration quadrature
[~,w]=ClenshawCurtis(0, pi/2, N-1);
w=r0*sec(t).^2.*w(:);
r=r0*x;

% Solve eigensystem
B=diag(x);
Dx=diag(cos(t).^2)*Dt;
T=-1/2*B*Dx^2;
V=-eye(N);
H=T+V;
[S,E]=eig(H(2:end-1,2:end-1), B(2:end-1,2:end-1));
[E,id]=sort(diag(E));
E=E0*E(1:k);

% Normalize eigenfunction
U=zeros(N,k);
U(2:end-1,:)=S(:,id(1:k));
U=U/diag(sqrt(diag(U'*diag(w)*U)));
U=bsxfun(@times, U, sign(U(end-1,:)));

% Calculate Bohr radius
u=U(:,1);
[umax, imax]=max(abs(u).^2);
rq=linspace(r(imax-1), r(imax+1), 1024);
uq=interp1(r,u,rq,'spline');
[umax, imax]=max(abs(uq).^2);
rbohr=rq(imax);

% Plot
Psi=bsxfun(@rdivide, U, r);
plot(r, Psi);
xlim([0,20]);
legend([num2str((0:k-1)','E_{%d}'), num2str(E,'=%f')]);
xlabel('$r$','Interpreter','latex');
ylabel('$\Psi_n(r)$','Interpreter','latex');
print -depsc p02g01;
end