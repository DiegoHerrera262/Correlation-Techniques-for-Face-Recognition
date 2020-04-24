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

% Sample filters
f1 = create_filter('superior.png', resol, scale_factor);
f2 = create_filter('inferior.png', resol, scale_factor);
f3 = create_filter('latizq.png', resol, scale_factor);
f4 = create_filter('latder.png', resol, scale_factor);
f5 = create_filter('frontal.png', resol, scale_factor);

% Synthesized filter
a = [0.1 0.1 0.1 0.4 0.4];
filter = a(1)*f1 + a(2)*f2 + a(2)*f3 + a(4)*f4 + a(5)*f5;

cam = webcam(2);
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
corimage = insertMarker(uint8(mysurface),location,'o','color','green','size',15);

subplot(2,1,1)
imshow(target,[]);
title('Target Image');

subplot(2,1,2)
imshow(corimage,[]);
title('Correlation Output');