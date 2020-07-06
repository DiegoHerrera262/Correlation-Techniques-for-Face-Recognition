%% Program for computing True Positive Rate
% Date: 05 - 07 - 20
% Author: Diego Herrera
% Description: In this program, The PSR indicator is used to compute the
%              total of true events cathegorized as positive as a 
%              proportion of truly positive events.

function tpr = TPR(truedirname,filttype,threshold)
    %% Compute PSE values over true class set
    [psrvals, ~, ~] = PSR_Database(truedirname,truedirname,filttype);
    
    %% Count events cathegorized as true class
    TruePositive = length(psrvals(psrvals >= threshold));
    
    %% Compute TPR
    tpr = TruePositive/length(psrvals);
end