%VLC CORRELATOR SIMPLE SIMULATION FOR FACE RECOGNITION-using only eyes as ref 3-LUIS CARLOS DURAN
%Date: 06-05-2020
%This code calculates and shows the result of the correlation function
%between a target and a reference image, using the method of a VLC type architecture and a single reference.
%Here the reference is only the eyes and nose of the subjcet, and the target is the face. Also since
%the reference is now smaller than the target, we ADD ZEROS to the reference to solve this problem
%HERE THE ZEROS ARE ADDED TO THE IMAGE MATRIX
%A COMPOSITE FILTER prototype is used which coeficients for the linear combination are
%computed based on a PCE criteria.
clear all;
close all;
clf;
clc;
%Images have 3 DIM-; rgb images have 2 dim.
addpath('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto\Image_Database')
%SET OF REFERENCE IMAGES
img_r=imread('eeyes1.png');
%TEST IMAGES
img_t=imread('eyes1.png');

%TRANSFORMING IMAGES TO GRAY SCALE
%REFERENCE IMAGES:
Ir=rgb2gray(img_r); 
%TARGET IMAGES:
It= rgb2gray(img_t); %Target image

%FIXING SIZES
%Create i,j
i=(size(It,1)-size(Ir,1))./2;j=(size(It,2)-size(Ir,2))./2; 
%i and j are the number of rows and colums (containing zeros) that must be added to the matrix 
%corresponding to the reference. The idea is to add the zeros around such
%matrix, so that its FT size coincides with the target's FT. 

%Padarray adds zeros around matrix, only works for image toolbox
Ir= padarray(Ir,[i j],0);

%SHOW IMAGES
figure(1);subplot(1,2,1);imshow(It);subplot(1,2,2);imshow(Ir);sgtitle('Target(L) and reference(R)')

%FT OF TARGET AND REFERENCES
%References
Fr=fft2(Ir);
%Target
Ft=fft2(It);
%SHIFT THE FT FOR LATER PLOT OF THEIR MAGNITUDES
Fr_sh=fftshift(Fr);
Ft_sh=fftshift(Ft);
%SHOW FOURIER SPECTRUMS
figure(2);subplot(1,2,1);imshow(Ft_sh);subplot(1,2,2);imshow(Fr_sh);sgtitle('Shifted Re[FT] of Target(L) and reference(R)')
%THIS ONLY WOULD BE TO SEE HOW ARE THE SHIFTED |FT|
figure(3);subplot(1,2,1);imagesc(log(abs(Ft_sh)+1));subplot(1,2,2);imagesc(log(abs(Fr_sh)+1));sgtitle('Shifted |FT| of target(L) and reference with extra zero values(R)')

%PARTIAL CORRELATIONS
pc=ifft2(Ft.*Fr);

%CALCULATING PCE FOR EACH CORRELATION (EXPLAINATION AT THE BUTTOM)
E_plane_ij=abs(ifft2(Ft.*Fr)).^2; ET_plane=sum(E_plane_ij,'all')                          
ET_peak=abs(max(pc,[],'all')).^2 %abs(max(pc2,[],'all')).^2 abs(max(pc3,[],'all')).^2 abs(max(pc4,[],'all')).^2 abs(max(pc5,[],'all')).^2 abs(max(pc6,[],'all')).^2 abs(max(pc7,[],'all')).^2 abs(max(pc8,[],'all')).^2 abs(max(pc9,[],'all')).^2 abs(max(pc10,[],'all')).^2]
PCE=ET_peak./ET_plane


%CONSTRUCTIION OF COMPOPSITE FILTER 
a=0.8; %0.5<=a<=1.5
A=(PCE).^(-a)

H_COM2=Fr.*A(1);%+Fr2.*A(2)+Fr3.*A(3)+Fr4.*A(4)+Fr5.*A(5)+Fr6.*A(6)+Fr7.*A(7)+Fr8.*A(8)+Fr9.*A(9)+Fr10.*A(10); %COM filter constructed in a rustic way
H_COM3=sign(real(H_COM2)); %COM BINARY filter constructed from H_COM2

%INCLUSION OF FILTER IN FOURIER PLANE-Multiplying filter by Target's FT.
P=Ft.*H_COM2;
P2=Ft.*H_COM3;

%TOTAL CORRELATION
c=ifft2(P); %inverse transform of the product mentioned above
C=ifftshift(c);% Shift the result

c2=ifft2(P2); %inverse transform of the product mentioned above
C2=ifftshift(c2);% Shift the result

%SURFACES
pos1 = [0.25 0.44 0.5 0.5];
pos2 = [0.4 0.04 0.3 0.3]; %[left bottom width height]

figure(4);subplot('position',pos1);mesh(log(1+abs(C)));colormap(jet);title('shifted Correlation using H_{COM2}')%result using H_COM2
subplot('position',pos2); imagesc(log(1+abs(C)));colormap(jet); colorbar;                    %log needed to scale

figure(5);subplot('position',pos1);mesh(1+abs(C2));colormap(jet);title('shifted Correlation using H_{COM3}')%Result using H_COM3
subplot('position',pos2); imagesc(1+abs(C2));colormap(jet); colorbar;                    %log NOT needed