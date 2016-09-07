function [] = actRejection( N )
mu=1;
sig=3;

% Box
x1=mu-3*sig;
x2=mu+3*sig;
y1=0;
y2=1/(sqrt(2*pi)*sig);

Z=[];
m=2*N;
while length(Z)<N
    X=x1+(x2-x1)*rand(m,1);
    Y=y1+(y2-y1)*rand(m,1);
    f=exp(-((X-mu)/sig).^2/2)/(sqrt(2*pi)*sig);
    m0=length(Z);
    Z=[Z; X(Y<=f)];
    m=ceil(1.5*m*(N-length(Z))/(N-m0));
end
Z=Z(1:N);
histogram(Z,60);
fprintf('mean = %f\nstd =%f\n', mean(Z), std(Z));
end

