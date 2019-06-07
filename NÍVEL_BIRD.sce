///////////////////////////////////////////////////////////////////////
clc
clear 

global lambda g

//****************************
//****  DADOS DE ENTRADA  ****
//****************************

disp('DIÂMETRO INTERNO DO TUBO (EM CENTÍMETROS)')
D=input('D= ')

disp('DIÂMETRO INTERNO DO FURO (EM MILÍMETROS)')
d=input('d= ');

disp('NÍVEL DE LÍQUIDO DENTRO DO TUBO (EM CENTÍMETROS)')
H=input('H= ');

disp('DIGITE O NÚMERO DE PONTOS NO GRÁFICO, P. EX. 100')
N=input('N= ');

g=9.81; // (m/s2)
D=0.01*D; // m
d=0.001*d; // m
H=0.01*H; // m
lambda=(D^4-d^4)/d^4;



//**************************
// EQUAÇÃO DIFERENCIAL *****
//**************************

function dy=F(t,h);

global  lambda g

dy=[h(2);(lambda*h(2)^2)/(2*h(1))-g];

endfunction



//*********************
// RESOLVENDO ODE *****
//*********************

h0=[H,-(2*g*H)^(1/2)*(d/D)^2];
t0=0;
tempo_total=(2)*(H/((2*g*H)^(1/2)*(d/D)^2)); 
n=tempo_total/N;
t=0:n:tempo_total;
h=ode(h0,t0,t,F)

//************************************
// MONTANDO O VETOR COLUNA NÍVEL *****
//************************************

nivel=[];
c=1;
for i = 1:2:2*(N+1)
    nivel(c,1)= h(1,i);
    c=c+1;
end

tempo=t';


//*********************
//     GRAFICANDO *****
//*********************

plot(tempo/60,100*nivel,'r-');
xtitle("PROBLEMA DO BIRD et al. (2004)","tempo (min)","Nível (cm)")
legend(["Comportamento teórico"],1);

/////////////////////////////////////////////////////////////////////////
