% Program for troubleshooting a sample image
% Date : 24 - 04 - 20
% Author: Diego Alejandro Herrera
% Description: This program takes pictures from webcam, and creates filter
%              in order o determine real time location of person's face in 
%              a video. The program compares correlation.

%% Clear workspace
clear all; close all; clc;

%% Read template image
im1 = rgb2gray(imread('Diego/sample1.png'));
%im1 = EnhanceBorder(imread('Diego/sample1.png'),5);
fftim1 = fft2(im1);
orgsize = size(im1);

%% Read test image
% Read scene image from webcam
cam = webcam(2);
scene = snapshot(cam);
scsize = size(rgb2gray(scene));
% Take & Crop image for template matching
x0 = int16(scsize(2)/2) - int16(orgsize(2)/2);
y0 = 0;
rect = [x0, y0, orgsize(2), orgsize(1)];
% Show Image for scene capture
textPos = [0 0];
t = 0;
tic
while t <= 20
    t = toc;
    text = num2str(t,'%0.2f');
    scene = snapshot(cam);
    scene = insertShape(scene,'Rectangle',rect,'LineWidth',5);
    scene = insertText(scene,textPos,text,'FontSize',32);
    imshow(scene);
end
%% Crop image
sample = imresize(EnhanceBorder(imcrop(scene,rect),5),orgsize);
fft_sample = fft2(sample);

%% Computation of 1-Sample MACE
x = fftim1(:);                  % Column vector with image
D = x .* conj(x);               % Average Spectrum
iDx = x .* (1.0 ./ D);          % D^{-1}X
MACE = iDx / (conj(x') * iDx);  % MACE Filter formula
% Resize for correlation computation
MACE = reshape(MACE,orgsize(1),orgsize(2));

%% Correlation using fft
% Different "correlations"
selfcorA = abs(fftshift(...
    ifft2(conj(fftim1) .* fftim1)));
selfcorB = abs(fftshift(...
    ifft2(sqrt(conj(fftim1) .* fftim1))));
selfcorC = abs(fftshift(...
    ifft2(conj(MACE) .* fftim1)));
selfcorD = MACExcorr(fftim1,'Diego');

%% Show Image and Filter
figure(1);
subplot(2,1,1); imshow(sample,[]); title('Sample Image');
subplot(2,1,2); imshow(im1,[]); title('Training Image');
%% Show Self Correlation
figure(2);
subplot(2,2,1); surf(selfcorA); title('Real Definition');
subplot(2,2,2); imshow(im1,[]); title('Training Image');
subplot(2,2,3); surf(selfcorC); title('Using 1-samp MACE');
subplot(2,2,4); surf(selfcorD); title('Using full MACE');