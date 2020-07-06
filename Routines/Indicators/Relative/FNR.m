%% Program for computing False Negative Rate
% Date: 05 - 07 - 20
% Author: Diego Herrera
% Description: In this program, The PSR indicator is used to compute the
%              total of true events cathegorized as negative, as a 
%              proportion of truly positive events.

function fnr = FNR(truedirname,filttype,threshold)
    %% Compute PSE values over true class set
    [psrvals, ~, ~] = PSR_Database(truedirname,truedirname,filttype);
    
    %% Count events cathegorized as false class
    FalseNegative = length(psrvals(psrvals < threshold));
    
    %% Compute FNR
    fnr = FalseNegative/length(psrvals);
end