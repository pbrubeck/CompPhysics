function [d] = tspsa(x, y, its)
% Travelling salesman problem solved by simulated annealing  
z=x+1i*y;
n=length(z);

phi=angle(z-mean(z));
[~,tour]=sort(phi);
d=sum(abs(diff(z(tour))));
temp=d;

h=plot(x(tour), y(tour));
for i=1:its
    d0=d;
    s1=mod(round(n*rand(1)),n)+1;
    s2=mod(s1-1+round(randn(1)/4),n)+1;
    cand=tour;
    cand([s1, s2])=tour([s2, s1]);
    d=sum(abs(diff(z(cand))));
    if(d<d0)
        tour=cand;
    elseif exp((d0-d)/temp)>rand(1)
        tour=cand;
    end
    temp=temp*0.99;
end
set(h,'XData',x(tour));
set(h,'YData',y(tour));
drawnow;
end