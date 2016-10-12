function [] = act04( N )
w=2i*pi*[0:N/2-1, 0, -N/2+1:-1]';
w=2i*pi*fftshift(0:N-1)';

x1=fournodes(-10,10,N);
y1=exp(-x1.^2);
dy1=1/20*real(ifft(w.*fft(y1)));
figure(1); plot(x1,dy1);

x2=fournodes(-1,1,N);
y2=sin(2*pi*x2);
dy2=1/2*real(ifft(w.*fft(y2)));
figure(2); plot(x2,dy2);

x3=fournodes(-10,10,N);
y3=atan(x3);
dy3=1/20*dct((1:N)'.*dst(y3));
figure(3); plot(x3,dy3);
end

function [x]=fournodes(a,b,N)
x=a+(b-a)/N*(1:N); x=x(:);
end