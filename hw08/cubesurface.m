function [p] = cubesurface(N)
p=min(1, 1-(1-2./N).^3);
plot(N, p, 'linewidth', 2);

dx=0.1*(N(end)-N(1));
dy=0.1*(p(end)-p(1));
tex{1}=xlabel('$N$');
tex{2}=text(N(2)+dx, p(2)+dy, '$p(N)=1-(1-\frac{2}{N})^3$');
cellfun(@(x) set(x,'Interpreter','latex'), tex);
cellfun(@(x) set(x,'fontsize',14), tex);
print -depsc act08g03;
end