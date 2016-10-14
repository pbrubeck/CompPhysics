function [] = act04( N )
w=2i*pi*[0:N/2-1, 0, -N/2+1:-1]';

x1=fournodes(-5,5,N);
y1=exp(-x1.^2);
dy1=1/10*real(ifft(w.*fft(y1)));
figure(1); plot(x1,[y1,dy1],'linewidth',2);
tex{1}=title('$f(x)=\exp(-x^2)$');
tex{2}=legend('$f(x)$', '$df/dx$');
tex{3}=xlabel('$x$');
cellfun(@(x) set(x,'Interpreter','latex'), tex);
cellfun(@(x) set(x,'fontsize',14), tex);
print('act04g01','-depsc');

x2=fournodes(-1,1,N);
y2=sin(2*pi*x2);
dy2=1/2*real(ifft(w.*fft(y2)));
figure(2); plot(x2,[y2,dy2],'linewidth',2);
tex{1}=title('$f(x)=\sin(2\pi x)$');
tex{2}=legend('$f(x)$', '$df/dx$');
tex{3}=xlabel('$x$');
cellfun(@(x) set(x,'Interpreter','latex'), tex);
cellfun(@(x) set(x,'fontsize',14), tex);
print('act04g02','-depsc');

w=1i*pi*[0:N-1, 0, -N+1:-1]';
x3=fournodes(-20,20,N);
y3=atan(x3);
yhat3=w.*fft([y3; -y3]);
dy3=1/40*real(ifft(yhat3)); dy3=dy3(1:N);
figure(3); plot(x3,[y3,dy3],'linewidth',2);
tex{1}=title('$f(x)=\tan^{-1}(x)$');
tex{2}=legend('$f(x)$', '$df/dx$');
tex{3}=xlabel('$x$');
cellfun(@(x) set(x,'Interpreter','latex'), tex);
cellfun(@(x) set(x,'fontsize',14), tex);
print('act04g03','-depsc');
end

function [x]=fournodes(a,b,N)
x=a+(b-a)/N*(1:N); x=x(:);
end