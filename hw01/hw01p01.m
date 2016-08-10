function []=hw01p01(N)
figure(1);
error(-50, N);
title('x=50');
figure(2);
error(50, N);
title('x=-50');
end

function err=error(x, N)
n=0:N-1;
err=abs(exp(x)-cumsum((x.^n)./factorial(n)));
semilogy(n, err);
end