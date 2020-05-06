% Program for troubleshooting a sample image
% Date : 24 - 04 - 20
% Author: Diego Alejandro Herrera
% Description: This program takes pictures from webcam, and creates filter
%              in order o determine real time location of person's face in 
%              a video. The program compares correlation.

%% Clear workspace
clear all; close all; clc;

%% Load MACE Filter
myfilter = load('filters/Diego_filter.mat');
myfilter = myfilter.filter;
myfilter = conj(myfilter);

%% Load Sample Image
sample = rgb2gray(imread('Diego/sample100.png'));
fft_sample = fftshift(fft2(sample));

%% Compute correlation
fft_cor = myfilter .* fft_sample;
cor = abs(ifft2(fft_cor));

%% Display correlation, sample image  & filter
subplot(2,3,1);
title('MACE Filter');
show_filter('Diego');
subplot(2,3,3);
title('Reference Image')
imshow(sample,[]);
title('Correlation Output')
subplot(2,3,5);
surf(cor);