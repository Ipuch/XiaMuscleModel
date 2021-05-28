%clear all
%T. Xia, L.A. Frey Law / Journal of Biomechanics 41 (2008) 3046–3052 3047

Lr = 10 ; % Relaxation factor LR
Ld = 10 ; % Development factor LD
F = 0.1; % fatigue rate 
R = 0.02 ; % recovery rate T. Xia, L.A. Frey Law / Journal of Biomechanics 41 (2008) 3046–3052 3047

% parameters
p = [F; R; Ld; Lr] ;

% Time parameters
dt = 0.1 ; 
tf = 50 ;
tspan = 0:dt:tf ;
TL = 1 * ones([tf/dt+1 1]) ;

% Spline to handle variable time-step of integrators
ppe = spline(tspan,TL) ;

% State variable
% X=[Ma, Mr, Mf]
% Differential equations of first order
% dX = f(X,t)

% Initial Conditions
%Ma= 0; Mr = 1; Mf =0;
X0 = zeros(3,1) ; 
X0(2,1) = 1;

% Integrate differential equation
[t,y] = ode45(@(t,X)f_sysdiff(t,X,p,ppe), ...
                   tspan, X0) ;

% Plot the Compartements
figure(1); clf;
plot(t,y(:,1),'-','LineWidth',2); hold on ;
plot(t,y(:,2),'-','LineWidth',2) ;
plot(t,-(y(:,1)+y(:,2))+1,'-','LineWidth',2) ;
plot(t,y(:,3)) ;
plot(t,TL,'k--') ;

legend('Ma','Mr','Mf','target load','location','best') ;

xlabel('time') ;
ylabel('% MUs') ;


% Residual Capactity
% RC = Ma + Mr ;

% Brain Effort
% BE = f_BE(TL, RC) ;