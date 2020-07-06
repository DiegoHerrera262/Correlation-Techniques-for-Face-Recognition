%% Program for computing  PSR indicator for Correlation over Dataset
% Date: 05 - 07 - 20
% Author: Diego Herrera
% Description: In this program, The PSR indicator is computed over a
%              database with a correlation filter associated with a
%              particular individual.

function [psrvals, peakloc, idx] = PSR_Database...
    (truedirname,dirname,filttype)
    %% Parameters of folder for PSE computation
    folder = [pwd() '/ProcessedDatabase/' ...
        dirname '_filtered'];               % Name of data folder
    MatchName = '/*sample*.png';            % Sample name of image files
    
    %% Definition of data location
    folderLocation = [folder MatchName];
    
    %% Read images on folder
    Data = dir(folderLocation);             % Read data from folder
    basefolder = Data.folder;
    
    %% Compute PSR & Peak Location for data
    peakloc = zeros(numel(Data),2);
    psrvals = zeros(numel(Data),1);
    idx = zeros(numel(Data),1);
    for k = 1:numel(Data)
        % Extract real image index
        s1 = split(Data(k).name,'sample');
        s2 = split(char(s1(2)),'.');
        idx(k) = uint16(str2double(char(s2(1))));
        % Read training-test image
        filename = [basefolder '/' Data(k).name];
        im = imread(filename);
        % Compute correlation
        corrplane = CFxcorr(im,truedirname,filttype);
        % Compute PSE and Peak Location
        [psr, location] = PSR(corrplane);
        psrvals(k) = psr;
        peakloc(k,1) = location(1);
        peakloc(k,2) = location(2);
    end
    
end