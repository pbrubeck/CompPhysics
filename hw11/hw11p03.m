function [] = hw11p03( mu, m )
n=length(mu);
T=zeros(size(mu));
for i=1:n
    T(i)=period(mu(i),0.8,m);
end
plot(mu(T<n), T(T<n))

end

function T=period(mu,x0,n)
j=0; x=x0; figs=7;
z=round(x, figs, 'significant');
mapObj = containers.Map('KeyType','double','ValueType','int32');
while j<n && ~mapObj.isKey(z)
    mapObj(z)=j;
    x=mu*x*(1-x);
    z=round(x, figs, 'significant');
    j=j+1;
end

T=n;
if j<n, T=j-mapObj(z); end;
end