%% Program For testing working of filters and correlation
% Date: 18 - 06 - 20
% Author: Diego Alejandro Herrera Rojas
% Description: This program asses whether certain filter has been created
%              correctly using a partituclad Database. It produces a
%              plot of a correlation output that is used to see if
%              the peaks ar sharp enough.

function demoFilter(refimag,filtname,filttype)
    %% Perform filter computation
    % impath contains the path of the basic image in the filter
    impath = 'none';
    if strcmp(filttype,'MINACE')
        impath = MINACE_Filter(filtname,refimag,1,10);
    else
        impath = MACE_Filter(filtname,refimag,1,10);
    end
    
    %% Read image for output demo
    % the output name of *_filter is a cell for demo, 1 element cell.
    imname = char(impath);
    im = imread(imname);
    
    %% Show correlation output
    figure(100);
    surf(CFxcorr(im,filtname,filttype));
    title(['Demo of ' filttype ' Performance']);
end