function [ w ] = hw10p02(m, train, sim)
% line y=m*x
% neuron 2*((w*x+bias)>0)-1
bias=1;
w=rand(1,2);
alpha=0.01;

xsim=rand(2,sim);
p=sign([-m 1]*xsim);
out=sign(w*xsim+bias);
err=mean(p~=out);
display(w);
fprintf('P(error) = %f\n', err);

xtrain=rand(2,train);
p=sign([-m 1]*xtrain);
for i=1:train
    out=sign(w*xtrain(:,i)+bias);
    w=w+alpha*((p(i)-out)*xtrain(:,i)');
end

p=sign([-m 1]*xsim);
out=sign(w*xsim+bias);
err=mean(p~=out);

figure(1);
scatter(xsim(1,p~=out),xsim(2,p~=out),3,'b'); hold on;
plot([0,1],[0,m],'r','linewidth',2); hold off;
print('hw10g02','-depsc')

fprintf('Neuron trained with %d evals and simulated with %d pts\n', train, sim);
fprintf('P(error) = %f\n', err);
end