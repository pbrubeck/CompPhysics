function [p,r] = hw05p02(n, trials)
% Secretary problem
r=ceil(n*exp(-1));
[~,rank]=sort(rand(n,trials));
goal=max(rank(1:r,:));
rank=rank(1+r:end,:);
c=rank>repmat(goal,size(rank,1),1);
[~,id]=max(c, [], 1);
m=size(rank,1);
best=rank(id+(0:m:m*(trials-1)));
b=(sum(c)==0);
best(b)=rank(end,b);
p=mean(best==n);
end