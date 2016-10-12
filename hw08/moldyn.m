function [] = moldyn(N,d)
% d number of dimensions
% N number of particles

L=4*N^(1/d); % Lenght of container
T0=2000;      % Initial temperature
tf=10;        % Final time
R=2^(1/6)/2; % Collision radius
dL=R/1000;   % Max step

x0=L*rand(N,d);
v0=sqrt(T0)*randn(N,d);

[s1,s2,s3]=sphere(20);
[s1,s2,s3]=deal(R*s1,R*s2,R*s3);
cmap=hsv(N);
figure(1); 
h=cell(N,1);
for j=1:N
    h{j}=surf(s1+x0(j,1), s2+x0(j,2), s3+x0(j,3), ...
        'EdgeColor', 'none', 'FaceColor', cmap(j,:));
    if(j==1), hold on; end;
end
camlight; hold off;
xlim([0,L]); ylim([0,L]); zlim([0,L]);
daspect([1,1,1]);

t=0;
x1=x0;
x2=zeros(size(x0));
while t<tf
    F=zeros(size(x0));
    for dx=[-L,0,L]
        x2(:,1)=x1(:,1)+dx;
        for dy=[-L,0,L]
            x2(:,2)=x1(:,2)+dy;
            for dz=[-L,0,L]
                x2(:,3)=x1(:,3)+dz;
                F=F+force(x1, x2);
            end
        end
    end
    dt=sqrt(dL/max(sqrt(dot(F,F,2))));
    t=t+dt;
    if(t==0)
        v=v0;
        x1=mod(x0+v0*dt+F*dt^2/2,L);
    else
        v=(x1-x0)/dt+F*dt;
        temp=x1;
        x1=mod(x1+v*dt,L);
        x0=temp;
    end
    
    
    for j=1:N
        set(h{j}, ...
        'XData', s1+x1(j,1), ...
        'YData', s2+x1(j,2), ...
        'ZData', s3+x1(j,3));
    end
    T=1/(N*d)*sum(sum(v.^2));
    title(sprintf('T=%f',T));
    drawnow;
end
end

function F=force(pos, pos2)
EPS=10;
F=zeros(size(pos));
dx=zeros(size(pos,1),size(pos,1),size(pos,2));
for i=1:size(pos,2)
    [x1,x2]=ndgrid(pos(:,i),pos2(:,i));
    dx(:,:,i)=x1-x2;
end
r2=sum(dx.^2, 3)+eye(size(pos,1));
r6=r2.^3; r12=r6.^2;
A=4*EPS*(12./r12-6./r6)./r2;
A(1:size(pos,1)+1:end)=0;
for i=1:size(pos,2)
    F(:,i)=sum(A.*dx(:,:,i),2);
end
end