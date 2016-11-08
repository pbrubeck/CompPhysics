function [] = cobwebs(f, x0, n)
% Fixed point x=f(x)
for i=1:n
    y0=f(x0);
    x(2*i-1:2*i)=[x0,y0];
    y(2*i-1:2*i)=[y0,y0];    
    x0=y0;
end
t=linspace(0,pi/2,1024);
figure(1);
plot(t,t,'g','LineWidth',2); hold on;
plot(t,f(t),'b','LineWidth',2);
plot(x,y,'r','LineWidth',1);
hold off;
print('act11g02','-depsc');
end