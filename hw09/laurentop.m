function [] = laurentop( n )
L=10;
x=linspace(-L,L,n); x=x(:);
h=2*L/(n-1);
y=exp(-x.^2/2);
yy=(-x).*y;

d=[-1/12, 2/3, 0, -2/3, 1/12]/h;
dy=conv(y,d,'same');
figure(1); plot(x,yy-dy,'linewidth',2);
tex{1}=title('Error, centered differences $O(h^4)$');
tex{2}=xlabel('$x$');
cellfun(@(x) set(x,'Interpreter','latex'), tex);
cellfun(@(x) set(x,'fontsize',14), tex);
print('act01g01','-depsc');

k=1:n-1;
r=[0, -((-1).^k)./k]/h;
L=toeplitz(-r,r);
Ly=L*y;
figure(2); plot(x,yy-Ly,'linewidth',2);
tex{1}=title('Error, Laurent operator');
tex{2}=xlabel('$x$');
cellfun(@(x) set(x,'Interpreter','latex'), tex);
cellfun(@(x) set(x,'fontsize',14), tex);
print('act01g02','-depsc');
end