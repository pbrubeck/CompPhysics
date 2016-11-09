function [] = hw11p02(a, b, x0, n)
xdata=[];
ydata=[];
for i=1:length(b)
    j=0; x=x0; figs=12;
    z=round(x, figs, 'significant');
    mapObj = containers.Map('KeyType','double','ValueType','int32');
    while j<n && ~mapObj.isKey(z)
        mapObj(z)=j;
        x=exp(-a*x.^2)+b(i);
        z=round(x, figs, 'significant');
        j=j+1;
    end
    
    T=min(n,64);
    if j<n, T=j-mapObj(z); end;
    for k=1:T
        xdata=[xdata; b(i)];
        ydata=[ydata; x];
        x=exp(-a*x.^2)+b(i);
    end
end
scatter(xdata,ydata,'r','.');
end

