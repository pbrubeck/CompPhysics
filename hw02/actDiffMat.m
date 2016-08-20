function [] = actDiffMat( ns )
e2=zeros(1,length(ns));
e4=zeros(1,length(ns));
e6=zeros(1,length(ns));
for i=1:length(ns)
    n=ns(i);
    
    L=10;
    h=2*L/(n-1);
    x=linspace(-L,L,n); x=x(:);
    y=exp(-x.^2);
    yy=-2*x.*y;
    
    if(false)
        r=zeros(n,1);
        r(1:2)=[0, -1/2];
        D2=toeplitz(r,-r);
        r(1:3)=[0, -2/3, 1/12];
        D4=toeplitz(r,-r);
        r(1:4)=[0, -3/4, 3/20, -1/60];
        D6=toeplitz(r,-r);

        y2=D2*y/h;
        y4=D4*y/h;
        y6=D6*y/h;
    else
        y2=conv(y, [1/2, 0, -1/2]/h, 'same');
        y4=conv(y, [-1/12, 2/3, 0, -2/3, 1/12]/h, 'same');
        y6=conv(y, [1/60, -3/20, 3/4, 0, -3/4, 3/20, -1/60]/h, 'same');
    end

    e2(i)=norm(yy-y2,'inf');
    e4(i)=norm(yy-y4,'inf');
    e6(i)=norm(yy-y6,'inf');
end
loglog(ns,[e2;e4;e6]);
set(gca,'XMinorTick','off');
set(gca, 'XTick', ns);
set(gca, 'XTickLabel', num2str(log2(ns(:)), '2^{%d}'));
xlabel('N'); ylabel('error');
legend(num2str([2;4;6],'O(h^%d)'));
print -depsc act02g01;
end