function [p] = hw04p01(N)
% Buffon's needle problem 
% N = number of trials
L=10;                    % number of lines
x=L*randlcg(N,1);        % center of needles
theta=2*pi*randlcg(N,1); % angle of needles
dx=cos(theta);           % horizontal spread 
p=mean(abs(floor(x+0.5*dx)-floor(x-0.5*dx)));
end