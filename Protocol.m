%% Program that carries out the whole protocol of the project
% Date : 30 - 05 - 20
% Author: Diego Alejandro Herrera Rojas
% Description: This program carries out the protocol described in the
%              project for all subjects in tha database, after acquisition.

%% Clean Workspace
clear all; close all; clc;

%% Set up MATLAB environment
setup;

%% Get Subject Names
disp('BEGIN PROTOCOL EXECUTION');
% Read Subject names on database
path = [pwd() '/ProcessedDatabase'];
Subjects = dir([pwd() '/RawDatabase']);
% Define reference size
refsize = [267, 308];
% Get plausible sets for comparison
Subs = {};
for k = 1:numel(Subjects)
    falseSubject = Subjects(k).name;
    cond = (strcmp(falseSubject,'.') | ... 
        strcmp(falseSubject,'..'));
    if ~cond
        impath = [path '/' falseSubject ...
            '_filtered' '/filtered_sample1.png'];
        if isfile(impath)
            candsize = size(imread(impath));
            cond1 = candsize == refsize;
            if cond1
                Subs{end +1} = falseSubject;
                disp(['Identified ' ...
                    falseSubject ' with correct size']);
            end
        end
    end
end

%% Preprocess datasets
for k = 1:numel(Subs)
    filter_images(Subs{k});
end
disp('Stage 1 Completed: Finished Preprocessing');

%% Train MACE Filter
irefimagsMACE = zeros([numel(Subs) 1]);
numsampMACE = 2;
for k = 1:numel(Subs)
    [irefimagsMACE(k), ~] = ...
        idealTrainingParameters(Subs{k},numsampMACE,'MACE');
end
disp('Stage 2a Completed: Finished Training for MACE');

%% Train HBCOM Filter
irefimagsHBCOM = zeros([numel(Subs) 1]);
numsampHBCOM = 4;
for k = 1:numel(Subs)
    [irefimagsHBCOM(k), ~] = ...
        idealTrainingParameters(Subs{k},numsampHBCOM,'HBCOM'); 
end
disp('Stage 2b Completed: Finished Training for HBCOM');

%% JUMPING HBCOM TRAINING (HBCOM is better thatn MACE use its refimags)
% Comment this section if you want to perform HBCOM complete training
% but keep in mind this is time consuming
irefimagsHBCOM = irefimagsMACE;
numsampHBCOM = 4;

%% Perform Simulation for each Subject's MACE
for k = 1:numel(Subs)
    falseidx = mod(k,numel(Subs))+1;
    usedImages = performSimulation(...
        Subs{k},Subs{falseidx},irefimagsMACE(k),numsampMACE,'MACE');
    movegui(gcf,'northwest');
end
disp('Stage 3a Completed: Finished Simulation for MACE');

%% Perform Simulation for each Subject's HBCOM
for k = 1:numel(Subs)
    falseidx = mod(k,numel(Subs))+1;
    usedImages = performSimulation(...
        Subs{k},Subs{falseidx},irefimagsHBCOM(k),numsampHBCOM,'HBCOM');
    movegui(gcf,'southwest');
end
disp('Stage 3b Completed: Finished Simulation for HBCOM');

%% Compute ROC curves for MACE
thresholdsMACE = zeros([numel(Subs) 1]);
for k = 1:numel(Subs)
    possibleThresholds = ROC_Space(Subs{k},'MACE');
    thresholdsMACE(k) = possibleThresholds(1);
    movegui(gcf,'northeast');
end
disp('Stage 4a Completed: Finished ROC Analysis for MACE');

%% Compute ROC curves for HBCOM
thresholdsHBCOM = zeros([numel(Subs) 1]);
for k = 1:numel(Subs)
    possibleThreshold = ROC_Space(Subs{k},'HBCOM');
    thresholdsHBCOM(k) = possibleThreshold(1);
    movegui(gcf,'southeast');
end
disp('Stage 4b Completed: Finished ROC Analysis for HBCOM');

%% Compute Confusion Matrices for MACE
ConfMatsMACE = cell(numel(Subs),1);
for k = 1:numel(Subs)
    ConfMatsMACE{k} = ...
        ConfusionMatrix(Subs{k},'MACE',thresholdsMACE(k));
end
disp('Stage 5a Completed: Finished Conf. Mat Computations for MACE');

%% Compute Confusion Matrices for HBCOM
ConfMatsHBCOM = cell(numel(Subs),1);
for k = 1:numel(Subs)
    ConfMatsHBCOM{k} = ...
        ConfusionMatrix(Subs{k},'MACE',thresholdsHBCOM(k));
end
disp('Stage 5b Completed: Finished Conf. Mat Computations for HBCOM');