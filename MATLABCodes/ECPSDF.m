% Program that performs facial identification using ECPSDF filter
% Date : 24 - 04 - 20
% Author: Diego Alejandro Herrera
% Description: This program takes pictures from webcam, and creates filter
%              in order o determine real time location of person's face in 
%              a video. The program does two things:
%              1) It records images for filter syntetization
%              2) It locates person's face in real time video

% Clean up
clear cam;
close all;

cam = webcam(2);
t = 0;
tic;

myfilter = load(fullfile(pwd(),'filters','Diego_filter.mat'));
Filter = myfilter.filter;
filter = zeropadd(Filter,[720,1280]); 

while(t <= 30)
    t = toc;
    target = rgb2gray(snapshot(cam));

    % Convolve image with filter
    fft_target = fftshift(fft2(target));
    fft_cor = conj(filter) .* fft_target;
    % Careful with fftshift
    cor = ifft2(fft_cor);

    % Prepare correlation for determining maxima
    mysurface = abs(log(1+abs(cor)));
    delta = max(max(mysurface))-min(min(mysurface));
    mysurface = 255*(mysurface-min(min(mysurface)))/delta;

    hLocalMax = vision.LocalMaximaFinder('MaximumNumLocalMaxima',1, ...
                                      'NeighborhoodSize',[3,3], ...
                                      'Threshold',0.90);

    location = hLocalMax(mysurface);                              
    target = insertMarker(target,location,'o','color','green','size',15);
    corimage = insertMarker(uint8(mysurface),location,'o','color', ...
        'green', 'size',15);

    figure(1);
    imshow(target,[]);

    % figure(2)
    % imshow(corimage,[]);
end