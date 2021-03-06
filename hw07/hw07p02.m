function [] = hw07p02(n)
% Traces route from z0 to zf with n midpoints inside an obstacle course
global LB UB z0 zf B1 B2 box;
LB=0; UB=500;
z0=250+500i;
zf=250+0i;

box=[100+100i; 100+100i; 100+100i; 100+100i; 100+100i; 100+100i];
B1=[60+350i; 175+300i; 290+250i; 100+150i; 215+100i; 330+50i];
B2=B1+box;

opts=gaoptimset();
opts=gaoptimset(opts,'Display', 'off');
opts=gaoptimset(opts,'PlotFcns', @plotfunc);
opts=gaoptimset(opts,'PlotInterval', 1);
[x,f]=ga(@fitfunc,2*n,[],[],[],[],zeros(1,2*n),ones(1,2*n),[],opts);

if f<100
    fprintf('Route is feasable in %d steps\n', n+1);
end
simpleplot(x);
end

function dz=mapDisplacements(x)
r=10+90*x(1:2:end);
t=2*pi*x(2:2:end);
dz=r.*exp(1i*t);
end

function [g]=obstacles(z)
global UB LB B1 B2;
x=real(z); dx=diff(x);
y=imag(z); dy=diff(y);
g=norm(x(x<LB)-LB,1)+norm(x(x>UB)-UB,1)+norm(y(y<LB)-LB,1)+norm(y(y>UB)-UB,1);
for k=1:length(B1)
    xa=real(B1(k));
    xb=real(B2(k));
    ya=imag(B1(k));
    yb=imag(B2(k));
    
    t1=(xa-x(1:end-1))./dx;
    t2=(xb-x(1:end-1))./dx;
    t3=(ya-y(1:end-1))./dy;
    t4=(yb-y(1:end-1))./dy;
    
    h1=y(1:end-1)+dy.*t1;
    h2=y(1:end-1)+dy.*t2;
    h3=x(1:end-1)+dx.*t3;
    h4=x(1:end-1)+dx.*t4;
    
    b1=(h1>=ya & h1<=yb & t1>=0 & t1<=1);
    b2=(h2>=ya & h2<=yb & t2>=0 & t2<=1);
    b3=(h3>=xa & h3<=xb & t3>=0 & t3<=1);
    b4=(h4>=xa & h4<=xb & t4>=0 & t4<=1);
    
    g=g+2*(xb-xa+yb-ya)*sum([b1,b2,b3,b4])+...
        sum(min(abs(h1(b1)-ya), abs(yb-h1(b1))))+...
        sum(min(abs(h2(b2)-ya), abs(yb-h2(b2))))+...
        sum(min(abs(h3(b3)-xa), abs(xb-h3(b3))))+...
        sum(min(abs(h4(b4)-xa), abs(xb-h4(b4))));
end
end

function [f]=fitfunc(x)
global z0 zf;
dz=mapDisplacements(x);
z=[cumsum([z0, dz]) zf];
d=abs(z(end)-z(end-1));
f=d+max(100,d)*obstacles(z);
end

function [state]=plotfunc(options,state,flag)
[~,imin]=min(state.Score);
simpleplot(state.Population(imin,:));
gen=state.Generation;
%print(sprintf('gen%03d',gen),'-depsc');
end

function []=simpleplot(t)
global z0 zf LB UB B1 box;
dz=mapDisplacements(t);
z=[cumsum([z0, dz]), zf];
plot(z,'-or', 'linewidth', 2); xlim([LB, UB]); ylim([LB, UB]);
hold on;
for k=1:length(B1)
    rectangle('EdgeColor', [0,0,1], 'linewidth', 1, ...
    'Position', [real(B1(k)), imag(B1(k)), real(box(k)), imag(box(k))]);
end
hold off;
end