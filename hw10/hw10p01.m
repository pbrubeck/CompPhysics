function [] = hw10p01( alpha, n )
x=linspace(-10,10,n);
y=1./(1+exp(alpha(:)*x));
plot(x, y, 'linewidth', 2);

tex{1}=xlabel('$x$');
tex{2}=legend(num2str(alpha(:), '$\\alpha=%.2f$'));
cellfun(@(x) set(x,'Interpreter','latex'), tex);
cellfun(@(x) set(x,'fontsize',14), tex);
print -depsc hw10g01;
end

