function [Emin, opt] = tspsa(x, y, attempts)
% Travelling salesman problem solved by simulated annealing  
figure(1);
h=plot(x, y, '-*');

z=x+1i*y;
n=length(z);
phi=angle(z-mean(z));
[~,opt]=sort(phi);
Emin=sum(abs(diff(z(opt([1:end,1])))));
its=25*n;

fail=0;
while fail<attempts
    tour=opt;
    E0=Emin;
    T=E0;
    alpha=(1e200*T)^(-1/its);
    succ=0;
    for i=1:its
        r=2*randn(1);
        a=mod(round(n*rand(1)),n);
        b=round(a+r+sign(r));
        id=mod(a:sign(b-a):b,n)+1;
        
        trial=tour;
        trial(id)=tour(fliplr(id));
        E=sum(abs(diff(z(trial([1:end,1])))));
        if exp((E0-E)/T)>rand(1)
            tour=trial; E0=E;
            if(E<Emin)
                Emin=E;
                opt=tour;
                set(h,'XData',x(opt([1:end,1])));
                set(h,'YData',y(opt([1:end,1])));
                drawnow;
                succ=succ+1; fail=0;
            end
        end
        T=alpha*T;
    end
    fail=fail+(succ==0);
end
end