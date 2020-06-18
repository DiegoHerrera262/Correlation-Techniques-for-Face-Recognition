%VLC CORRELATOR SIMPLE SIMULATION FOR FACE RECOGNITION 2-LUIS CARLOS DURAN
%Date: 03-05-2020
%This code calculates and shows the result of the correlation function
%between a target and a reference image, using the method of a VLC type architecture and multiple references.
%A COMPOSITE FILTER prototype is used which coeficients for the linear combination are
%chosen in an arbitrary way.-NOT A GOOD RESULT.
clear all;
close all;
clf;
clc;
%Images have 3 DIM-; rgb images have 2 dim.
addpath('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto\Image_Database')
%SET OF REFERENCE IMAGES
img_r=imread('face1.png');
img_r2=imread('face2.png');img_r2=imresize3(img_r2,size(img_r));
img_r3=imread('face3.png');img_r3=imresize3(img_r3,size(img_r));
img_r4=imread('face4.png');img_r4=imresize3(img_r4,size(img_r));
img_r5=imread('face5.png');img_r5=imresize3(img_r5,size(img_r));
img_r6=imread('face6.png');img_r6=imresize3(img_r6,size(img_r));
%TEST IMAGES
img_t=imread('face1.png');
img_t2=imread('face1.png');
img_t2=imresize3(img_t2,size(img_r));% Resizes the image

%TRANSFORMING IMAGES TO GRAY SCALE
%TARGET IMAGES:
It2=rgb2gray(img_t2);
It= rgb2gray(img_t); %Target image
%REFERENCE IMAGES:
Ir=rgb2gray(img_r); 
Ir2=rgb2gray(img_r2);
Ir3=rgb2gray(img_r3);
Ir4=rgb2gray(img_r4);
Ir5=rgb2gray(img_r5);
Ir6=rgb2gray(img_r6);

%FT OF TARGET AND REFERENCES
%Target
Ft=fft2(It);St=abs(Ft);Rt=mat2gray(log(1+St));
Ft_sh=fftshift(Ft);St_sh=abs(Ft_sh);Rt_sh=mat2gray(log(1+St_sh));%_sh meaning shifted
%References
Fr=fft2(Ir);Sr=abs(Fr);Rr=mat2gray(log(1+Sr));
%Fr_sh=fftshift(Fr);Sr_sh=abs(Fr_sh);Rr_sh=mat2gray(log(1+Sr_sh));
Fr2=fft2(Ir2);Fr3=fft2(Ir3);Fr4=fft2(Ir4);Fr5=fft2(Ir5);Fr6=fft2(Ir6);

%CONSTRUCTIION OF COMPOPSITE FILTER 
A=[0.02 0.04 0.06 0.08 0.10 0.12]; %Create an array with the coeficients to be used for the filter
%coeficients in  this example are arbitrary
%H_COM=0;
%for i=1:length(A)
 %   H_COM= H_COM+A(i).*FT_R(i); -THIS "FOR" ISN'T WORKING 
%end
%H_COM;
H_COM2=Fr.*A(1)+Fr2.*A(2)+Fr3.*A(3)+Fr4.*A(4)+Fr5.*A(5)+Fr6.*A(6);  %COM filter constructed in a rustic way

%INCLUSION OF FILTER IN FOURIER PLANE-Multiplying filter by Target's FT.
P=Ft.*H_COM2;
%CORRELATION
c=ifft2(P); %inverse transform of the product mentioned above
C=ifftshift(c); % Shift the result

%SURFACES
pos1 = [0.25 0.44 0.5 0.5];
pos2 = [0.4 0.04 0.3 0.3]; %[left bottom width height]

figure(1);subplot('position',pos1);mesh(log(1+abs(C)));colormap(jet);title('shifted Correlation')
subplot('position',pos2); imagesc(log(1+abs(C)));colormap(jet); colorbar;  
