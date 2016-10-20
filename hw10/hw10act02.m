function [] = hw10act02( x )
wand=[1;1];
band=-2;

wor=[1;1];
bor=-1;

wnot=[-1;0];
bnot=0;

Hand=1*((x*wand+band)>=0);
Hor=1*((x*wor+bor)>=0);
Hnot=1*((x*wnot+bnot)>=0);

disp(table(x, Hand, Hor, Hnot));
end

