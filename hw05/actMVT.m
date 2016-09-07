function [ J ] = actMVT( N )
% Integration via Mean Value Theorem
J=mean(sum(rand(10,N)).^2);
end