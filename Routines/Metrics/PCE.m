%% Program that computes PSE in a correlation plane
% Date : 18 - 06 - 20
% Author: Diego Alejandro Herrera
% Description: This program takes a correlation plane and returns the peak
%              to correlation energy of the plane. It is assumed to be
%              the optical output, i.e. a real matrix

function pce = PCE(corrplane)
    %% Determination of the peak value
    corrplane2 = (corrplane(:)).^2;
    peakval = max(corrplane2);
    
    %% Determination of the total energy
    energy = sum(corrplane2);
    
    %% Computation of PCE
    pce = peakval/energy;
end