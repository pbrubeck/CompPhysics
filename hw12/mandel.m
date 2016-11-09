function [ ] = mandel(n)
x1=-2; x2=2;
y1=-2; y2=2;

x=linspace(x1,x2,n);
y=linspace(y1,y2,n);
[xx,yy]=meshgrid(x,y);
zz=xx+1i*yy;

ww=zz;
id=NaN(n); i=0;
while i<256
    b=(isnan(id)) & (abs(ww)>=2);
    id(b)=i; 
    d=isnan(id);
    ww(d)=ww(d).^2+zz(d);
    i=i+1;
end
id(isnan(id))=i+1;


figure(1);
imagesc(x,y,id);
colormap(jet(256));
axis equal;


figure(2);
ww(id<=i)=0;
imagesc(x,y,abs(ww));
colormap(jet(256));
axis equal;
end

