function dX = f_sysdiff(t,X,p,ppe)
% Ordinary differential equations of muscle fatigue
% according to T. Xia, L.A. Frey Law / Journal of Biomechanics 41 (2008) 3046–3052 3047
% INPUTS
%   - t time (scalar)
%   - X State variables (3x1)
%   - p parameters (4x1)
%   - ppe spline parameters
% OUTPUTS
%   - dX derivative of the state variables

F  = p(1);
R  = p(2);
Ld = p(3);
Lr = p(4);

Ma = X(1) ;
Mr = X(2) ;
Mf =1- (Ma+ Mr) ; % acordding to equation (3)

% Interpolation for non provided points
TL=ppval(ppe,t); 

% Time-varying activation-deactivation drive computation
C = f_C(TL, Ma, Mr, Ld, Lr) ;

if Mf>=1
    %keyboard
end

% equation (1)
dMa = C - F * Ma ;
dMr = -C + R * Mf ;
dMf = F * Ma - R * Mr ;

dX(1,1) = dMa ;
dX(2,1) = dMr ;
dX(3,1) = dMf ;
end