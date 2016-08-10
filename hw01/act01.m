function [mu] = act01(N, m)
pos=sum(2*(rand(N,m)>0.5)-1);
histogram(pos);
mu=mean(abs(pos));
end