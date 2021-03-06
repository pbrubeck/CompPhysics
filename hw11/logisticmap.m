function [] = logisticmap(mu, x0, n)
xdata=[];
ydata=[];
for i=1:length(mu)
    j=0; x=x0; figs=8;
    z=round(x, figs, 'significant');
    mapObj = containers.Map('KeyType','double','ValueType','int32');
    while j<n && ~mapObj.isKey(z)
        mapObj(z)=j;
        x=mu(i)*x*(1-x);
        z=round(x, figs, 'significant');
        j=j+1;
    end
    
    T=min(n,64);
    if j<n, T=j-mapObj(z); end;
    for k=1:T
        xdata=[xdata; mu(i)];
        ydata=[ydata; x];
        x=mu(i)*x*(1-x);
    end
end
scatter(xdata,ydata,'r','.');
end

