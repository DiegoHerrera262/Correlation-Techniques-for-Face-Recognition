%% Program that sets up MATLAB environment for correct execution
% Author: Diego Alejandro Herrera Rojas
% Date: 18 - 06 - 20
% Description: Adds Routines folder to MATLABPATH so that there is no
%              problem during execution and files are saved and read
%              consistently inside application.

%% Add folders to MATLAB PATH
addpath(genpath(fullfile(pwd(),'Routines')));

%% Print mesage confirming user
disp('Correct Initialization of Environment');
disp('Please make sure that master folder remains most external one');