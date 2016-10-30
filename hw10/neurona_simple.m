x=0:.001:1;
fact=.95;
y=x*fact;
plot(x,y);
   axis([0,1,0,1]);
hold on;

wx=rand(1);
wy=rand(1);

tote=1e7; %[2,5,7];
xn=rand(1,tote);
yn=rand(1,tote);

bias=1;

out=sum(wx.*xn+wy.*yn+bias);

%-------
factor=.01;

exito=0;
fracaso=0;

display('Entrenando la neurona artificial...');
for cont=1:1:length(xn)


out=sum(wx.*xn(cont)+wy.*yn(cont)+bias);

if out>0
    out=1;
else
    out=-1;
end

yverd=xn(cont)*fact;

if yn(cont)>yverd
    deseado=1;
elseif yn(cont)<yverd
    deseado=-1;
end

wx=wx+(deseado-out)*factor*xn(cont);

wy=wy+(deseado-out)*factor*yn(cont);


if deseado==out
    exito=exito+1;
else 
    fracaso=fracaso+1;
end
end
%pause;
display('Entrenamiento finalizado!');

pause;
for cont=1:1:length(xn)
    figure(2)
    plot(x,y);
       axis([0,1,0,1]);
    hold on;
    plot(xn(cont),yn(cont),'o');
    axis([0,1,0,1]);
   
    
    hold off;
    out=sum(wx.*xn(cont)+wy.*yn(cont)+bias);
    
    if out>0
    out=1;
    else
    out=-1;
    end

    
    if out>0
    display('La neurona dice: el punto está arriba');
    else
        display('La neurona dice: el punto está abajo');
    end
    pause;
 end
    