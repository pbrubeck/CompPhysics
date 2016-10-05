function [xsup, its] = genmaxf(f, a, b, ndims, nbits, N)
% Map n bits to [a, b]
binmax=2^nbits-1;
map=@(bin) bsxfun(@plus, bin*diag((b-a)/binmax), a);

% Generate random population
pop=randi(2^nbits,N,ndims)-1;

% Fitness function
fit=apply(f, map(pop), ndims);
[fsup,id]=max(fit);
sup=pop(id,:);

its=0;
fail=0;
while fail<2000
    % Selection
    p=cumsum(fit/sum(fit));
    [~,j]=max(bsxfun(@ge, p, rand(1,N)));
    pop=pop(j,:);
    
    % Reproduction
    par1=pop(1:2:end,:);
    par2=pop(2:2:end,:);
    msk1=bitshift(1,randi(nbits,size(par1)))-1;
    msk1(rand(size(msk1))>0.5)=binmax;
    msk2=bitxor(msk1, binmax);
    pop(1:2:end,:)=bitor(bitand(par1, msk1), bitand(par2, msk2));
    pop(2:2:end,:)=bitor(bitand(par2, msk1), bitand(par1, msk2));
    
    % Mutation
    msk3=(rand(N,nbits)<0.01)*(2.^(0:nbits-1)');
    msk3=repmat(msk3, [1,ndims]);
    pop=bitxor(pop, msk3);
    
    % Determine who has been the fittest
    fit=apply(f, map(pop), ndims);
    [fmax,id]=max(fit);
    if(fmax>=fsup)
        fsup=fmax;
        sup=pop(id,:);
        fail=(fmax==fsup)*fail;
    else
        fail=fail+1;
    end
    its=its+1;
end
xsup=map(sup);
end

function y=apply(f, x, mode)
switch mode
    case 1,
        y=f(x);
    case 2,
        y=f(x(:,1),x(:,2));
    case 3,
        y=f(x(:,1),x(:,2),x(:,3));
    otherwise,
        y=zeros(size(x,1),1);
        for i=1:size(x,1)
            y(i)=f(x(i,:).');
        end
end
end