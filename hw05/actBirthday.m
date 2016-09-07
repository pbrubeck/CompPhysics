function [p] = actBirthday(N, trials)
A=mod(round(365*rand(N,trials)),365)+1;
p=mean(prod(diff(sort(A)))==0);
end