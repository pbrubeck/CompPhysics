function [] = molarr(Nbody, dims)           
global N d L R cmap;
N=Nbody;
d=dims;
L=4*N^(1/d);
R=2^(1/6)/2;
cmap=hsv(N);

nvars=(N-1)*d;
opts=gaoptimset();
opts=gaoptimset(opts,'Display', 'off');
opts=gaoptimset(opts,'PlotFcns', @plotfnc);
opts=gaoptimset(opts,'PlotInterval', 1);
[x,f]=ga(@fitfnc,nvars,[],[],[],[],zeros(1,nvars),ones(1,nvars),[],opts);

simpleplot(x);
end

function V=potential(pos)
EPS=10;
r2=eye(size(pos,1));
for i=1:size(pos,2)
    [x1,x2]=ndgrid(pos(:,i),pos(:,i));
    r2=r2+(x1-x2).^2; 
end
r6=r2.^3; r12=r6.^2;
V=4*EPS*sum(1./r12-1./r6, 2);
end

function [pos]=mapPos(x)
global N d L;
pos=[ones(1,d)*L/2; reshape(L*x,[N-1,d])];
end

function [f]=fitfnc(x)
pos=mapPos(x);
V=potential(pos);
f=sum(V/2);
end

function [state]=plotfnc(options,state,flag)
[~,imin]=min(state.Score);
simpleplot(state.Population(imin,:));
end

function []=simpleplot(x)
global N d L R cmap;
pos=mapPos(x);
if(d==3)
    [s1,s2,s3]=sphere(20);
    [s1,s2,s3]=deal(R*s1,R*s2,R*s3);
    for j=1:N
        surf(s1+pos(j,1), s2+pos(j,2), s3+pos(j,3), ...
            'EdgeColor', 'none', 'FaceColor', cmap(j,:));
        if(j==1), hold on; end;
    end
    camlight;
    hold off;
    xlim([0,L]); ylim([0,L]); zlim([0,L]);
    daspect([1,1,1]);
elseif(d==2)
    scatter(pos(:,1), pos(:,2), 100, 'o', 'MarkerFaceColor', 'r',  'MarkerEdgeColor', 'k');
    xlim([0,L]); ylim([0,L]);
    daspect([1,1,1]);
end
end
