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
sample = rgb2gray(imread('Diego/sample50.png'));
fft_sample = fft2(sample);

%% Compute correlation
fft_cor = sqrt(conj(fft_sample) .* fft_sample);
cor = abs(fftshift(ifft2(fft_cor)));
fft_cor1 = sqrt(conj(M) .* fft_sample);
cor1 = abs(fftshift(ifft2(fft_cor1)));
tic;
fft_cor2 = sqrt(conj(Filter) .* fft_sample);
cor2 = abs(fftshift(ifft2(fft_cor2)));
t = toc;

%% Display correlation, sample image  & filter
subplot(2,2,1);
imshow(img,[]);
title('Reference Image')
subplot(2,2,2);
surf(cor)
title('Selfcorrelation')
subplot(2,2,3);
surf(cor1);
title('Correlation Output - With 1 Smp. MACE')
subplot(2,2,4);
surf(cor2);
title('Correlation Output - With Full MACE')