close all

dt = 0.1 ;
tf = [50;50;100;300] ;
N = tf(1)/dt+1;
TL = repmat([1;0.7;0.3;0.1],[1,N] ) ;

for ii =1:length(tf)
    ComputeMuscleCompartementXia(tf(ii),TL(ii,:),N)
    title(['Target Load ' num2str(TL(ii,1))])
end

TL=zeros(N,1);
tf = N;
Tuact=30;
Tudeact=30;
l=Tuact/dt+Tudeact/dt;

for ii=1:4
TL( (1:30)+(ii-1)*60) = 0
TL( (31:60)+(ii-1)*60) = 0.5
end
% TL(201:end)=[];

ComputeMuscleCompartementXia(N,TL,N);
title(['Target Load ' num2str(0.5) ' Pulse'])

tf  = 20;

TL = 0.3* sin( linspace(0, 2*5*pi, N) ) + 0.5 ;
ComputeMuscleCompartementXia(tf,TL,N);
title(['Target Load ' num2str(0.5) ' Harmonic'])


function ComputeMuscleCompartementXia(tf,TL,N)

Lr = 10 ;
Ld = 10 ;

F = 0.1;
R = 0.02 ; 


tspan = linspace(0,tf, N);
ppe = spline(tspan,TL) ;

p = [F; R; Ld; Lr] ;

%Conditions init
X0 = zeros(3,1) ; %Ma= 0; Mr = 1; Mf =0;
X0(2,1) = 1;

[t,y] = ode45(@(t,X)f_sysdiff(t,X,p,ppe), ...
                   tspan, X0) ;
figure()
plot(t,y(:,1),'-','LineWidth',2); hold on ;
plot(t,y(:,2),'-','LineWidth',2)

plot(t,-(y(:,1)+y(:,2))+1,'-','LineWidth',2)
plot(t,TL,'k--')

legend('Ma','Mr','Mf','target load','location','best')

xlabel('time')
ylabel('% MU')
end