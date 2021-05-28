close all
% Reproducing graphs of the article
% T. Xia, L.A. Frey Law / Journal of Biomechanics 41 (2008) 3046–3052 3047


% Figure 4
dt = 0.1 ;
tf = [50;50;100;300] ;
N = tf(1)/dt+1;
TL = repmat([1;0.7;0.3;0.1],[1,N] ) ;

for ii =1:length(tf)
    ComputeMuscleCompartementXia(tf(ii),TL(ii,:),N) ;
    title(['Target Load ' num2str(TL(ii,1))])
end


%% Figure 6
TL=zeros(N,1);

for ii=1:4
TL( (1:30)+(ii-1)*60) = 0 ;
TL( (31:60)+(ii-1)*60) = 0.5 ;
end

ComputeMuscleCompartementXia(N,TL,N);
title(['Target Load ' num2str(0.5) ' Pulse'])

tf  = 20;

TL = 0.3* sin( linspace(0, 2*5*pi, N) ) + 0.5 ;
ComputeMuscleCompartementXia(tf,TL,N);
title(['Target Load ' num2str(0.5) ' Harmonic'])

%%
function ComputeMuscleCompartementXia(tf,TL,N)
% Plot the graphs of the muscle compartements
% with different target loads
% final times
% N points
% according to T. Xia, L.A. Frey Law / Journal of Biomechanics 41 (2008) 3046–3052 3047

Lr = 10 ; % Relaxation factor LR
Ld = 10 ; % Development factor LD
F = 0.1; % fatigue rate 
R = 0.02 ; % recovery rate T. Xia, L.A. Frey Law / Journal of Biomechanics 41 (2008) 3046–3052 3047

% parameters
p = [F; R; Ld; Lr] ;

% Time parameters
tspan = linspace(0,tf, N);

% Spline to handle variable time-step of integrators
ppe = spline(tspan,TL) ;

% Initial Conditions
%Ma= 0; Mr = 1; Mf =0;
X0 = zeros(3,1) ; 
X0(2,1) = 1;

% Integrate differential equation
[t,y] = ode45(@(t,X)f_sysdiff(t,X,p,ppe), ...
                   tspan, X0) ;
               
% Plot the Compartements
figure()
plot(t,y(:,1),'-','LineWidth',2); hold on ;
plot(t,y(:,2),'-','LineWidth',2);
plot(t,y(:,3),'-','LineWidth',2);
% plot(t,-(y(:,1)+y(:,2))+1,'-','LineWidth',2)
plot(t,TL,'k--');

legend('Ma','Mr','Mf','target load','location','best');

xlabel('time');
ylabel('% MU');
end