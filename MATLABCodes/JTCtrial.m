%JTC CORRELATOR SIMPLE SIMULATION-LUIS CARLOS DURAN
%Date: 28-04-2020
%This code calculates and shows the result of the correlation function
%of an input image containing a target and a reference, using the method
%of a JTC type architecture.
clear all;
close all;
clf;
clc;
%Images have 3 DIM-; rgb images have 2 dim.
%READING IMAGES
addpath('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto')
%REFERENCE
img_r=imread('nasa.png'); %Reference
%TARGETS
img_t=imread('nasa.png'); %Target
img_t2=imread('Delorean.png');
img_t2=imresize3(img_t2,size(img_r));% Resizes the image with respect to reference

%TRANSFORMING IMAGES TO GRAY SCALE
It2=rgb2gray(img_t2);
It= rgb2gray(img_t); %Target image
Ir=rgb2gray(img_r); %Reference image
I=[It,Ir]; %creating input plane
figure(1);subplot(2,1,1);montage(I); title('Input plane: Target(L), Reference(R)')

%FT OF THE INPUT PLANE
F=fft2(I);S=abs(F);R=mat2gray(log(1+S));
F_sh=fftshift(F);S_sh=abs(F_sh);R_sh=mat2gray(log(1+S_sh)); %_sh meaning shifted
subplot(2,1,2);imshow(R_sh,[]); title('Shifted Fourier transform of image')

%SPECTRAL DENSITY
SD=S.^2;%spectrum taken from the original |FT|
SD_sh=S_sh.^2;%spectrum taken from the SHIFTED |FT|
figure(2);subplot(1,2,1); imshow(log(SD_sh),[]);title('Shifted Spectral density');

%CORRELATION-(LIENEAR)
c=ifft2(SD); %inverse transform of density spectrum
C=ifftshift(c);% Shift the result
subplot(1,2,2); imshow(log(1+abs(C)),[]); title('shifted Correlation')

%ADDING NON LINEARITY AND NEW CORRELATION
k=0.5;
c_NL=ifft2(SD.^k);
C_NL=ifftshift(c_NL);
figure(3);subplot(1,2,1); imshow(log(SD_sh),[]);title('Shifted Spectral density');
subplot(1,2,2);imshow(log(1+abs(C_NL)),[]); title('shifted Correlation with non-linearity')

%SURFACES
pos1 = [0.25 0.44 0.5 0.5];
pos2 = [0.4 0.04 0.3 0.3]; %[left bottom width height]

figure(4);subplot('position',pos1);mesh(log(1+abs(C)));colormap(jet);title('shifted Correlation')
subplot('position',pos2); imagesc(log(1+abs(C)));colormap(jet); colorbar; 


figure(5);subplot('position',pos1);mesh(log(1+abs(C_NL)));colormap(jet);title('shifted Correlation with non-linearity')
subplot('position',pos2); imagesc(log(1+abs(C_NL)));colormap(jet);colorbar;

