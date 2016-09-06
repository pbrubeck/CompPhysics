function [P] = hw04p02(N, mu, A)
% Probability of getting certain scoreboard as an outcome
% N = number of trials
% mu = mean scores for each team
% A = scoreboard for each match
p=randlcg(N,length(mu));
X=bsxfun(@times, mu, -log(1-p)); % exponential distribution
X=floor(X);
P=zeros(size(A,1),1);
for i=1:size(A,1)
    P(i)=mean(prod(bsxfun(@eq, X, A(i,:)),2));
end
end