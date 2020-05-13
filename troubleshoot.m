% Program for troubleshooting a sample image
% Date : 24 - 04 - 20
% Author: Diego Alejandro Herrera
% Description: This program takes pictures from webcam, and creates filter
%              in order o determine real time location of person's face in 
%              a video. The program compares correlation.

%% Clear workspace
clear all; close all; clc;

%% 1 Sample MACE Filter
% Read sample image
h = rgb2gray(imread('Diego/Sample50.png'));
orgsize = size(h);
h = fft2(h);
h = h(:);
img = reshape(h,orgsize);
img = ifft2(img);
% Compute MACE Filter
iDX = ((1.0 ./ abs(h).^2) .* h);
M = iDX / (conj(h') * iDX);
M = reshape(M,orgsize);

%% Full Data MACE Filter
Filter = load('filters/Diego_filter.mat');
Filter = Filter.filter;

%% Load Sample Image
% Read scene image from webcam
cam = webcam(2);
scene = snapshot(cam);
scsize = size(rgb2gray(scene));
% Take & Crop image for template matching
x0 = int16(scsize(2)/2) - int16(orgsize(2)/2);
y0 = 0;
rect = [x0, y0, orgsize(2), orgsize(1)];
%% Show Image for scene capture
textPos = [3*scsize(2)/8 6*scsize(2)/8];
t = 0;
tic
while t <= 20
    t = toc;
    text = num2str(t,'%0.2f');
    scene = snapshot(cam);
    scene = insertShape(scene,'Rectangle',rect,'LineWidth',5);
    scene = insertText(scene,textPos,text);
    imshow(scene);
end

%% Crop image
sample = imresize(rgb2gray(imcrop(scene,rect)),orgsize);
fft_sample = fft2(sample);

%% Compute correlation
fft_cor = sqrt(conj(fft2(img)) .* fft_sample);
cor = abs(fftshift(ifft2(fft_cor)));
fft_cor1 = sqrt(conj(M) .* fft_sample);
cor1 = abs(fftshift(ifft2(fft_cor1)));
tic;
fft_cor2 = sqrt(conj(Filter) .* fft_sample);
cor2 = abs(fftshift(ifft2(fft_cor2)));
t = toc;

%% Display correlation, sample image  & filter
subplot(2,3,1);
imshow(sample,[]);
title('Test Image')
subplot(2,3,3);
imshow(img,[]);
title('Sample Image')
subplot(2,3,4);
surf(cor)
title('Crosscorrelation')
subplot(2,3,5);
surf(cor1);
title('Correlation Output - With 1 Smp. MACE')
subplot(2,3,6);
surf(cor2);
title('Correlation Output - With Full MACE')