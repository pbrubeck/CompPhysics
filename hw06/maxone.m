function [sup,its] = maxone(nbits, N)
% Generate random population
pop=randi(2^nbits,N,1)-1;

% Fitness function
f=sum(de2bi(pop),2);
[fsup,id]=max(f);
sup=pop(id);

its=0;
fail=0;
while fail<10
    % Selection
    p=cumsum(f/sum(f));
    [~,j]=max(bsxfun(@ge, p, rand(1,N)));
    pop=pop(j);
    
    % Reproduction
    par1=pop(1:2:end);
    par2=pop(2:2:end);
    msk1=2.^randi(nbits,size(par1))-1;
    msk1(rand(size(msk1))>0.9)=2^nbits-1;
    msk2=(2^nbits-1)-msk1;
    pop(1:2:end)=bitor(bitand(par1, msk1), bitand(par2, msk2));
    pop(2:2:end)=bitor(bitand(par2, msk1), bitand(par1, msk2));

    % Mutation
    msk3=(rand(N,nbits)<0.01)*(2.^(0:nbits-1)');
    pop=bitxor(pop, msk3);
    
    % Determine who has been the fittest
    f=sum(de2bi(pop),2);
    [fmax,id]=max(f);
    if(fmax>=fsup)
        fsup=fmax;
        sup=pop(id);
        fail=0;
    else
        fail=fail+1;
    end
    its=its+1;
end
end