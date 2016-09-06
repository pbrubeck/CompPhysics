function [] = hw04p03(N, x)
% Returns the the number of individuals with X>=x within a population of
% size N with a normal distribution
mu=100;
sigma=15;

% Normal distribution via Box-Muller method
u=randlcg(N,2);
X=sqrt(-2*log(u(:,1))).*cos(2*pi*u(:,2));
X=mu+sigma*X;

n=sum(bsxfun(@ge, X, x));                % Simulation result
p=1-(0.5+erf((x-mu)/(sqrt(2)*sigma))/2); % Probabilistic result
err=abs(1-N*p./n);

fprintf('%d  people have IQ > %d \nRelative error = %f\n', n, x, err);
end