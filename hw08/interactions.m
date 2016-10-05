function [ k ] = interactions( n )
k=(n-1).*n/2;
plot(n,k,'k','linewidth',2);

dx=0.1*(n(end)-n(1));
dy=0.1*(k(end)-k(1));
tex{1}=xlabel('$N$');
tex{2}=text(n(end)-5*dx, k(end)-dy, '$k(N)=\frac{N(N-1)}{2}$');
cellfun(@(x) set(x,'Interpreter','latex'), tex);
cellfun(@(x) set(x,'fontsize',14), tex);

print -depsc act08g01;
end