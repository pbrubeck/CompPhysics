function [sup,its] = maxone(nbits, N)
binmax=bitshift(1,nbits)-1;
% Generate random population
pop=randi(2^nbits,N,1)-1;

% Fitness function
fit=sum(de2bi(pop),2);
[fsup,id]=max(fit);
sup=pop(id);

its=0;
fail=0;
while fail<1000
    % Selection
    p=cumsum(fit/sum(fit));
    [~,j]=max(bsxfun(@ge, p, rand(1,N)));
    pop=pop(j,:);
    
    % Reproduction
    par1=pop(1:2:end,:);
    par2=pop(2:2:end,:);
    msk1=2.^randi(nbits,size(par1))-1;
    msk1(rand(size(msk1))>0.5)=binmax;
    msk2=bitxor(msk1, binmax);
    pop(1:2:end)=bitor(bitand(par1, msk1), bitand(par2, msk2));
    pop(2:2:end)=bitor(bitand(par2, msk1), bitand(par1, msk2));

    % Mutation
    msk3=(rand(N,nbits)<0.01)*(2.^(0:nbits-1)');
    pop=bitxor(pop, msk3);
    
    % Determine who has been the fittest
    fit=sum(de2bi(pop),2);
    [fmax,id]=max(fit);
    if(fmax>=fsup)
        fsup=fmax;
        sup=pop(id);
        fail=(fmax==fsup)*fail;
    else
        fail=fail+1;
    end
    its=its+1;
end
end