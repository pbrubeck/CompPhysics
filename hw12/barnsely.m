function [] = barnsely(n, m, h)
z=1i*exp(2i*pi*(0:m-1)/m);
w=zeros(n,1);
w(1)=z(1);
for i=2:n
    k=randi(m,1);
    w(i)=z(k)+h*(w(i-1)-z(k));
end
scatter(real(w), imag(w), '.');
end