function [] = hw11p01(th0, dt, tf)
L=1; g=9.81;
t=0:dt:tf;
u=[th0(:)'; zeros(1,length(th0))];

nframes=floor(1+tf/dt);
th=zeros(nframes,length(th0));
th(1,:)=th0;
for i=2:nframes
    u=solveRK4(u, dt);
    th(i,:)=u(1,:);
end
figure(1);
plot(t, th, 'LineWidth', 2);

P=zeros(size(th0));
for i=1:length(th0)
    [~,pk]=findpeaks(th(:,i));
    P(i)=mean(diff(t(pk)));
end
disp(P);

T=4*sqrt(L/g)*ellipticK(sin(th0/2));
disp(T);

function v=partialTime(u)
v=[u(2,:); -g/L*sin(u(1,:))];
end

function u=solveRK4(u, dt)
k1=dt*partialTime(u);
k2=dt*partialTime(u+k1/2);
k3=dt*partialTime(u+k2/2);
k4=dt*partialTime(u+k3);
u=u+(k1+2*k2+2*k3+k4)/6;
end
end