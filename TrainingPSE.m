%% Program for Assesing MACE Filter Performance in Trainning set
% Date: 02 - 06 - 20
% Author: Diego Herrera
% Description: In this program a single MACE filter is computed
%              for a sample image and PSE is computed for the
%              correlation output of the other images in the
%              set. A plot of PSE vs. Image number is generated

%% Clear Workspace
clear all; close all; clc;

%% Parameters of True Folder location
curr_loc = pwd();                % Current MATLABPATH
dataFolder = 'Diego_filtered';  % Name of data folder
MatchName = '/*sample*.png';     % Sample name of image files

%% Parameters of False Folder location
falseFolder = '/Diego_filtered';          % Name of data folder
FalseName = '/*false*.png';      % Sample name of image files

%% Definition of True data location
folderLocation = [curr_loc '/' dataFolder MatchName];

%% Defnition of False data location
falseLocation = [curr_loc falseFolder FalseName];

%% Read True images on folder
Data = dir(folderLocation);      % Read data from folder
base = Data.folder;

%% Read False images on folder
Fake = dir(falseLocation);

%% Compute n-Sample MACE
filtername = 'MACE';
numsamp = 2;
subspsize = numel(Data);
refimag = 12;
usedImages = MACE_Filter(dataFolder,refimag,numsamp,subspsize);

%% Compute PSE and Peak location for True Data
peakloc = zeros(numel(Data),2);
psevals = zeros(numel(Data),1);
randomNum = 108;
for k = 1:numel(Data)
    % Read training-test image
    filename = [base '/' Data(k).name];
    im = imread(filename);
    % Compute correlation
    corrplane = CFxcorr(im,dataFolder,filtername);
    % Compute PSE and Peak Location
    [pse, location] = PSE(corrplane);
    psevals(k) = pse;
    peakloc(k,1) = location(1);
    peakloc(k,2) = location(2);
end

%% Compute PSE and Peak Location for False Data
fake_peakloc = zeros(numel(Fake),2);
fake_psevals = zeros(numel(Fake),1);
fake_randomNum = 108;
for k = 1:numel(Fake)
    % Read training-test image
    filename = [base '/' Fake(k).name];
    im = imread(filename);
    % Compute correlation
    corrplane = CFxcorr(im,dataFolder,filtername);
    % Compute PSE and Peak Location
    [pse, location] = PSE(corrplane);
    fake_psevals(k) = pse;
    fake_peakloc(k,1) = location(1);
    fake_peakloc(k,2) = location(2);
end

%% Compute mean values of PSE for both sets
meanT = mean(psevals); meanF = mean(fake_psevals);
numRange = 1:0.1:200;
meanTrue = meanT * ones(size(numRange));
meanFalse = meanF * ones(size(numRange));

%% Plot PSE Results
figure(1);
subplot(1,2,1);
scatter(1:numel(Data),psevals,'o','MarkerFaceColor','b'); hold on;
scatter(1:numel(Fake),fake_psevals,'o','MarkerFaceColor','r'); hold on;
plot(numRange,meanTrue,'LineWidth',2.0,'Color','b'); hold on;
plot(numRange,meanFalse,'LineWidth',2.0,'Color','r');
text(80,140,['PSE_T = ' num2str(meanT,3)],'FontSize',15,'Color','b');
text(80,120,['PSE_F = ' num2str(meanF,3)],'FontSize',15,'Color','r');
xlabel('No. Figura');
ylabel('PSE');
title(['PSE con referencia a imagen ' num2str(...
    refimag)]);
legend('True','False','Location','best');

%% Plot Location Results
subplot(1,2,2);
plot(1:numel(Data),peakloc(:,1),'-o',...
    'LineWidth',1.5,'Color','b'); hold on;
plot(1:numel(Data),peakloc(:,2),'-o',...
    'LineWidth',1.5,'Color','r'); hold on;
xlabel('No. Figura');
ylabel('Peak Location');
title('Localización Máximo');
legend('Corrd. y','Coord. x','Location','best');
