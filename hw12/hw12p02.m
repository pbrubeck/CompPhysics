function [] = hw12p02( n )
% Probability density
p=[0.25; 0.25; 0.25; 0.25];

% Affine transformations
A{1}=[ 0.14,  0.01, -0.08;  0.00,  0.51, -1.31; 0, 0, 1];
A{2}=[ 0.43,  0.52,  1.49; -0.45,  0.50, -0.75; 0, 0, 1];
A{3}=[ 0.45, -0.49, -1.62;  0.47,  0.47, -0.74; 0, 0, 1];
A{4}=[ 0.49,  0.00,  0.02;  0.00,  0.51,  1.62; 0, 0, 1];

% Roulette algorithm
[~,kk]=max(bsxfun(@le, rand(1,n-1), cumsum(p)));
x=zeros(3,n);
x(:,1)=[0;0;1];
for i=1:n-1
    x(:,i+1)=A{kk(i)}*x(:,i);
end

scatter(x(1,:), x(2,:), '.', 'MarkerEdgeColor', [0 0.5 0]);
daspect([1,1,1]); axis off;
print('hw12p02', '-depsc');
end