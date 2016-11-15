function [] = dragon( n )
S=[0;1];
a=[(1+1i)/2; (-1+1i)/2];
b=[0;1];

for i=1:n
    S=[a(1)*S+b(1); a(2)*flipud(S)+b(2)];
end

plot(real(S), imag(S), 'k', 'LineWidth', 1);
daspect([1,1,1]); xlim([-0.4, 1.2]); ylim([-0.4,0.8]);

end

