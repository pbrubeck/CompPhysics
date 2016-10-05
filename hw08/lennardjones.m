function [V,F] = lennardjones(epsilon, sig, r)
V=4*epsilon*((sig./r).^12-(sig./r).^6);
F=4*epsilon*(12*(sig^12./r.^13)-6*(sig^6./r.^7));

[Vmin, i1]=min(V);
[Fmin, i2]=min(F);

plot(r, [V; F], 'linewidth', 2); ylim([-3,5]);
hold on; plot([0,r(end)],[0,0],'--k'); hold off;

delta=0.12*r(end);
tex{1}=xlabel('$r/\sigma$');
tex{2}=text(r(i1)-delta, Vmin, '$V(r)$');
tex{3}=text(r(i2)-delta, Fmin, '$F(r)$');
cellfun(@(x) set(x,'Interpreter','latex'), tex);
cellfun(@(x) set(x,'fontsize',14), tex);
print -depsc act08g02;
end