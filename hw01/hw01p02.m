function []=hw01p02(L, ns)
figure(1); clf; hold on;
figure(2); clf; hold on;
figure(3); clf; hold on;
d6=[1/60, -3/20, 3/4, 0, -3/4, 3/20, -1/60];

for n=ns
h=L/(n-1);
x=linspace(-L/2, L/2, n);
y=sinc(x);
yy=(x.*cos(x)-sin(x))./x.^2;

y1=(y(2:end)-y(1:end-1))/h;
y2=(y(3:end)-y(1:end-2))/(2*h);
y6=conv(y, d6/h, 'valid');

figure(1);
semilogy(x(1:end-1), abs(yy(1:end-1)-y1));
figure(2);
semilogy(x(2:end-1), abs(yy(2:end-1)-y2));
figure(3);
semilogy(x(4:end-3), abs(yy(4:end-3)-y6));
end

legs=cellfun(@(x)({sprintf('n=%d',x)}), num2cell(ns));
figure(1); title('Forward O(h)');   legend(legs); hold off;
figure(2); title('Central O(h^2)'); legend(legs); hold off;
figure(3); title('Central O(h^6)'); legend(legs); hold off;
end

