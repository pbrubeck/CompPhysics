function [] = hw07p02(n)
global LB UB z0 zf B1 B2;
LB=0; UB=500;
z0=250+500i;
zf=0+0i;

B1=[100+200i; 60+350i; 175+350i; 290+350i; 50+50i];
B2=B1+[100+100i; 100+100i; 100+100i; 100+100i; 100+100i];

x=ga(@fitfun,2*n,[],[],[],[],zeros(1,2*n),ones(1,2*n),@nonlcon);
z=mapdisplacement(x);
w=cumsum([z0,z]);
figure(1);
plot(w,'-*'); xlim([LB, UB]); ylim([LB, UB]);
hold on;
B3=B2-B1;
for k=1:length(B1)
    rectangle('Position', [real(B1(k)), imag(B1(k)), real(B3(k)), imag(B3(k))]);
end
hold off;
end

function [f]=fitfun(x)
global z0;
z=mapdisplacement(x);
f=sum(abs(z));
plot(cumsum([z0, z])); drawnow;
end

function [c,ceq]=nonlcon(t)
global LB UB z0 zf B1 B2;
z=mapdisplacement(t);
w=cumsum([z0, z]); u=real(w); v=imag(w);
dp=diff(w); dx=real(dp); dy=imag(dp);

ceq=abs(sum(z)+z0-zf);
c=zeros(1,4+length(B1));
c(1)=norm(u(u<LB)-LB);
c(2)=norm(u(u>UB)-UB);
c(3)=norm(v(v<LB)-LB);
c(4)=norm(v(v>UB)-UB);

for k=1:length(B1)
    xa=real(B1(k));
    xb=real(B2(k));
    ya=imag(B1(k));
    yb=imag(B2(k));
    
    t1=(xa-u(1:end-1))./dx;
    t2=(xb-u(1:end-1))./dx;
    t3=(ya-v(1:end-1))./dy;
    t4=(yb-v(1:end-1))./dy;
    
    h1=v(1:end-1)+dy.*t1;
    h2=v(1:end-1)+dy.*t2;
    h3=u(1:end-1)+dx.*t3;
    h4=u(1:end-1)+dx.*t4;
    
    b1=(h1>=ya & h1<=yb & t1>=0 & t1<=1);
    b2=(h2>=ya & h2<=yb & t2>=0 & t2<=1);
    b3=(h3>=xa & h3<=xb & t3>=0 & t3<=1);
    b4=(h4>=xa & h4<=xb & t4>=0 & t4<=1);
    
    c(4+k)=sum(min(abs(h1(b1)-ya), abs(yb-h1(b1))))+...
           sum(min(abs(h2(b2)-ya), abs(yb-h2(b2))))+...
           sum(min(abs(h3(b3)-xa), abs(xb-h3(b3))))+...
           sum(min(abs(h4(b4)-xa), abs(xb-h4(b4))));
end
end

function z=mapdisplacement(x)
r=90*x(1:2:end)+10;
t=2*pi*x(2:2:end);
z=r.*exp(1i*t);
end