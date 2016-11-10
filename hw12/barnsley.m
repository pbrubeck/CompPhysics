function [] = barnsley(n, m, p, h)
z=1i*exp(2i*pi*(0:m-1)/m);
w=zeros(n,1);
w(1)=z(1);
k=1;
for i=2:n
    k=1+mod(k-1+randi([p,m-p],1),m);
    w(i)=z(k)+h*(w(i-1)-z(k));
end
scatter(real(w), imag(w), '.b');
daspect([1,1,1]); axis off;
%print('sierpinsky', '-depsc');
end