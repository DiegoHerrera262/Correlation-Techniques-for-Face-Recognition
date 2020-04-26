% Program that takes pictures and saves them in current directory
% Date : 24 - 04 - 20
% Author: Diego Alejandro Herrera
% Description: This program takes sample pictures and synthesizes them in
%              a matrix that is then stored. Remember to add MATLABCodes to
%              MATLAB path for execution of zeropadd.m

function synt_filter(dirname)
    % Establish location of images
    basedir = pwd();
    images = dir([basedir '/' dirname]);
    filename = [basedir '/' dirname '/' images(3).name];
    % Read image for size reference for filter
    im = rgb2gray(imread(filename));
    filter = fftshift(fft2(im));
    samplesize = size(im);
    for i = 3:numel(images)
        filename = [basedir '/' dirname '/' images(i).name];
        im = rgb2gray(imread(filename));
        filter = filter + fftshift(fft2(im));
        for k = 1:3
            im = imresize(im,0.25*k);
            ref = zeropadd(im,samplesize);
            filter = filter + fftshift(fft2(ref));
        end
        filter = 0.25 * filter;
    end
    filter = conj((1.0/numel(images)) * filter);
    mkdir('filters');
    save(fullfile(basedir,'filters',[dirname '_' 'filter.mat']),'filter','-mat');
end