function [] = hw04p01(ns)
% Buffon's needle problem 
% N = number of trials
L=10; % number of lines
p=[];
for n=ns
    z=randlcg(n,2);    % generate random numbers
    x=L*z(:,1);        % center of needles
    theta=2*pi*z(:,2); % angle of needles
    dx=cos(theta);     % horizontal projection
    % Determine on which tile each end of the needle will lie, and count
    % how many needles have their ends on different tiles
    p(end+1)=mean(abs(floor(x+0.5*dx)-floor(x-0.5*dx)));
end
approx=2./p; % p should be approximately 2/pi
err=abs(1-approx/pi);
loglog(ns, err, 'LineWidth', 3);
set(gca,'XMinorTick','off');
set(gca, 'XTick', ns);
set(gca, 'XTickLabel', num2str(log2(ns(:)), '2^{%d}'));
xlabel('N'); title('Relative error');
print -depsc p01g01;
end