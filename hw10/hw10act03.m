function [] = hw10act03()
x = 0:.05:30;
y = besselj(0,x);
net=newff([0 30],[30 1],{'tansig','purelin'},'traingd');
net.trainParam.epochs=1e4;
net.trainParam.goal=1e-5;
net1 = train(net,x,y);
a = sim(net1,x);

j0=sim(net1, pi);
fprintf('j0=%.15f\n', j0);
fprintf('err=%.15f\n', j0-besselj(0,pi));

plot(x,a,'o',x,y);
end