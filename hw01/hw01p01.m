function []=hw01p01(N)
figure(1);
error(-50, N);
title('x=-50');
set(gcf,'PaperSize',[4,3])
print('p01g01','-dpdf','-fillpage');
figure(2);
error(50, N);
title('x=50');
set(gcf,'PaperSize',[4,3])
print('p01g02','-dpdf','-fillpage');
end

function err=error(x, N)
n=0:N-1;
err=abs(exp(x)-cumsum((x.^n)./factorial(n)));
semilogy(n, err);
end