function [] = moldyn(N,d)
% d number of dimensions
% N number of particles

L=4*N^(1/d);          % Lenght of container
T0=10;                 % Initial temperature
dt=0.001;             % Time step
tf=10;
R=2^(1/6)/2;

pos=L*rand(N,d);
vel=sqrt(T0)*randn(N,d);

[s1,s2,s3]=sphere(20);
[s1,s2,s3]=deal(R*s1,R*s2,R*s3);
cmap=hsv(N);
figure(1); 
h=cell(N,1);
for j=1:N
    h{j}=surf(s1+pos(j,1), s2+pos(j,2), s3+pos(j,3), ...
        'EdgeColor', 'none', 'FaceColor', cmap(j,:));
    if(j==1), hold on; end;
end
camlight;

hold off;
xlim([0,L]); ylim([0,L]); zlim([0,L]);
daspect([1,1,1]);

pos2=pos;
for t=0:dt:tf
    F=zeros(size(pos));
    for dx=[-L,0,L]
        pos2(:,1)=pos(:,1)+dx;
        for dy=[-L,0,L]
            pos2(:,2)=pos(:,2)+dy;
            for dz=[-L,0,L]
                pos2(:,3)=pos(:,3)+dz;
                F=F+force(pos, pos2);
            end
        end
    end
    vel=vel+F*dt;
    pos=mod(pos+vel*dt,L);
    
    for j=1:N
        set(h{j}, ...
        'XData',s1+pos(j,1), ...
        'YData',s2+pos(j,2), ...
        'ZData',s3+pos(j,3));
    end
    drawnow;
    T=1/(N*d)*sum(sum(vel.^2));
    title(sprintf('T=%f',T));
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
A(logical(eye(size(pos,1))))=0;
for i=1:size(pos,2)
    F(:,i)=sum(A.*dx(:,:,i),2);
end
end