function [ ] = actIntegrate(ns)
approx=[];
for n=ns
    approx(end+1)=4*mean(rand(n,1).^2+rand(n,1).^2<=1);
end
err=abs(1-approx/pi);
loglog(ns, err, 'LineWidth', 3);
set(gca,'XMinorTick','off');
set(gca, 'XTick', ns);
set(gca, 'XTickLabel', num2str(log2(ns(:)), '2^{%d}'));
xlabel('N'); title('error');
print -depsc act05g02;
end

