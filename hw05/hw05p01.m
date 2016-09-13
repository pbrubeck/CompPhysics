function [mc, err] = hw05p01( ns, pts )
% Volume of a N-dimensional hyper-sphere
% N = max dimensions
% pts = number of points
V=pi.^(ns/2)./gamma(ns/2+1);
mc=zeros(size(ns));
for i=1:length(ns)
    n=ns(i);
    r=rand(n,pts);
    mc(i)=2^n*mean(dot(r,r,1)<=1);
end
err=abs(mc-V);
end