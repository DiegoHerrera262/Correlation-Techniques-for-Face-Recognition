% Program for experimenting with funny facil recognition
% Author: Diego Alejandro Herrera
% Date: 24 - 04 - 20
% Description: This code uses a funny filter synthesis algorithm contained
%              in syntehsize_filter.m file. It simply superimposes some
%              filters generated with four images of my face.

clear cam
close all

scale_factor = 0.1;
resol = [720 1280];
a = [0.1 0.1 0.4 0.4 0.6];

% Synthesized filter
filter = syntesize_filter(resol, scale_factor, a);

cam = webcam(2);
t = 0;
tic;
while(t <= 30)
    t = toc;
    target = rgb2gray(snapshot(cam));

    % Convolve image with filter
    fft_target = fftshift(fft2(target));
    fft_cor = filter .* fft_target;
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


