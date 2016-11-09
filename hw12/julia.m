function [] = julia(n,c)
x1=-1.5; x2=1.5;
y1=-1.5; y2=1.5;

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
    ww(d)=ww(d).^2+c;
    i=i+1;
end
id(isnan(id))=i+1;


figure(1);
imagesc(x,y,id);
colormap(jet(256));
axis equal;
end

