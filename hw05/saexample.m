% Simulated Annealing

N=1000;
J=1;
Kb=1;
t=1;
miu=1;

a=-10;
b=10;

x=linspace(a,b,100);
y=(1.5-exp(-(x-exp(1)/pi).^2)).*(exp(1)+.25*cos(x*3));

x0=rand(1)*(b-a)+a;
costo=inline('(1.5-exp(-(x-exp(1)/pi).^2)).*(exp(1)+.25*cos(x*3))');

fin=1000;
equil=[];

for iter=2:1:fin
    t=t-1e-4;
   
     t=t*.99;
 
     
     x_aux=(rand(1)*(b-a)+a);
    
    e_act=costo(x0);
    e_trial=costo(x_aux);
    
   cambio=abs(x0-x_aux*0);
    
    D_E=e_trial-e_act;
    
    if e_trial<e_act
    
        x0=x_aux;
        x_aux=x0;
        
    elseif e_trial>=e_act
    
        if rand(1,1)<=exp(-D_E/Kb/t);
          
            x0=x_aux;
            x_aux=x0;
 
        else
            x0=x0;
            x_aux=x0;
        end
        x0_aux=x0;
        
           plot(x,y,x0,costo(x0),'*');
           drawnow;
%                    iter
    end
equil=[equil,cambio];
    
end
figure;
plot(equil)