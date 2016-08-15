function []=hw01p02(L, ns)
figure(1); clf; 
figure(2); clf;
figure(3); clf;
d6=[1/60, -3/20, 3/4, 0, -3/4, 3/20, -1/60];

for n=ns
h=2*L/(n-1);
x=linspace(-L, L, n);
y=sinc(x);
yy=(x.*cos(x)-sin(x))./x.^2;

y1=(y(2:end)-y(1:end-1))/h;
y2=(y(3:end)-y(1:end-2))/(2*h);
y6=conv(y, d6/h, 'valid');

figure(1); semilogy(x(1:end-1), abs(yy(1:end-1)-y1)); hold on;
figure(2); semilogy(x(2:end-1), abs(yy(2:end-1)-y2)); hold on;
figure(3); semilogy(x(4:end-3), abs(yy(4:end-3)-y6)); hold on;
end

legs=cellfun(@(x)({sprintf('n=%d',x)}), num2cell(ns));
LOC='SouthEast';

figure(1); title('Forward O(h)');   legend(legs,'Location',LOC); hold off;
set(gcf,'PaperSize',[4,3])
print('p02g01','-dpdf','-fillpage');

figure(2); title('Central O(h^2)'); legend(legs,'Location',LOC); hold off;
set(gcf,'PaperSize',[4,3])
print('p02g02','-dpdf','-fillpage');

figure(3); title('Central O(h^6)'); legend(legs,'Location',LOC); hold off;
set(gcf,'PaperSize',[4,3])
print('p02g03','-dpdf','-fillpage');
end