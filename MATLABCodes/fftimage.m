% Program for experimenting with funny facil recognition
% Author: Diego Alejandro Herrera
% Date: 24 - 04 - 20
% Description: This code uses computation of correlation for target
%              identification

close all

% Read test image and reference image
testim = rgb2gray(imread('scene_better1.png'));
refim = imread('reference_better.png');

% Building test image for correlation computation
[ref_sizex,ref_sizey] = size(refim);
builttest = zeros(size(testim),'uint8');
for i = 1:ref_sizex
    for j = 1:ref_sizey
        builttest(i,j) = refim(i,j);
    end
end

% Compute correrlation of images
fft_builttest = conj(fftshift(fft2(builttest)));
fft_testim = fftshift(fft2(testim));
fft_cor = fft_builttest .* fft_testim;
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
testim = insertMarker(testim,location,'o','color','green','size',15);
corimage = insertMarker(uint8(mysurface),location,'o','color','green','size',15);

subplot(1,2,1)
imshow(testim,[]);
title('Target Image');

subplot(1,2,2)
imshow(refim,[]);
title('Reference Image');

% figure, surf(mysurface), shading flat

% J = fftshift(fft2(I));
% H = conj(J);
% 
% C = fftshift(ifft2(J .* H));
% 
% subplot(2,3,2);
% imshow(I,[]);
% title('Original Image');
% 
% subplot(2,3,4);
% imshow(abs(J),[]);
% title('FFT of Image');
% 
% subplot(2,3,6);
% imshow(abs(C),[]);
% title('Reconstructed Image');