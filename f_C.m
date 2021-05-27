function [C] = f_C(TL, Ma, Mr, Ld, Lr)
% Time-varying activation-deactivation drive computation
% according to equation (2) in T. Xia, L.A. Frey Law / Journal of Biomechanics 41 (2008) 3046–3052 3047
% INPUTS
%   - TL current Target Load (scalar)
%   - Ma (scalar)
%   - Mr (scalar)
%   - Ld (scalar)
%   - Lr (scalar)
% OUTPUTS
%   - C Time-varying activation-deactivation drive (scalar)


if Ma < TL && Mr >=(TL - Ma) 
    
    C = Ld * (TL - Ma) ;
    
elseif Ma < TL && Mr <(TL - Ma) 
    
    C = Ld * Mr ;
    
elseif Ma >= TL
    
    C = Lr * (TL - Ma) ;
    
end

end