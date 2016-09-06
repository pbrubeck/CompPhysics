function [X] = randlcg(varargin)
% Linear Congruential Generator.
% Returns a matrix of uniformly distributed random numbers between 0 and
% X = randlcg(sz1,...,szN)

% Numerical Recipes parameters
a=1664525;    % multiplier
c=1013904223; % increment
m=2^32;       % modulus
seed=round(1e9*now);   
seed=mod(seed, m);

X=zeros(cell2mat(varargin));
X(1)=mod(a*seed+c, m);
for i=2:numel(X)
    X(i)=mod(a*X(i-1)+c, m);
end
X=X/(m-1);
end

