function [ ] = fern(n)
% Probability density
p=[0.01; 0.85; 0.07; 0.07];

% Affine transformations
A{1}=[ 0.00,  0.00,  0.00;  0.00,  0.16,  0.00; 0, 0, 1];
A{2}=[ 0.85,  0.04,  0.00; -0.04,  0.85,  1.60; 0, 0, 1];
A{3}=[ 0.20, -0.26,  0.00;  0.23,  0.22,  1.60; 0, 0, 1];
A{4}=[-0.15,  0.28,  0.00;  0.26,  0.24,  0.44; 0, 0, 1];

% Roulette algorithm
[~,kk]=max(bsxfun(@le, rand(1,n-1), cumsum(p)));
x=zeros(3,n);
x(:,1)=[0;0;1];
for i=1:n-1
    x(:,i+1)=A{kk(i)}*x(:,i);
end

scatter(x(1,:), x(2,:), '.', ...
    'MarkerEdgeColor', [0 0.5 0]);
daspect([1,1,1]); axis off;
print('fern', '-depsc');
end

