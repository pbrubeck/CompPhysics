function [ ] = maxone( n )
a=0;
b=1;
delta=1/127;
nbits=ceil(log2((b-a)/delta+1));


pob=floor(a+rand(n,1)/delta);

f=sum(de2bi(pob),2);
p=f/sum(f);

survive=p>rand(n,1);

pob(survive)

end

