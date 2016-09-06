function [p1,p2] = hw04p04(N)
% Monty Hall problem simulation
X=mod(round(3*randlcg(N,2)),3); 
prize=X(:,1); % Prize door
first=X(:,2); % Player's first selection
% Probability of winning with no swap
p1=mean(first==prize);
% The presentator reveals a goat
reveal=3-prize-first;
% Handle special case: player picked the prize
b=(prize==first);
reveal(b)=mod(prize(b)+1+round(randlcg(size(prize(b)))), 3);
% The player swaps doors
swap=3-reveal-first;
% Probability of winning with swap
p2=mean(swap==prize);
end