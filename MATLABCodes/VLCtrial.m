%VLC CORRELATOR SIMPLE SIMULATION-LUIS CARLOS DURAN
%Date: 28-04-2020
%This code calculates and shows the result of the correlation function
%between a target image and a single reference image, using the method of a VLC type architecture.
clear all;
close all;
clf;
clc;
%Images have 3 DIM-; rgb images have 2 dim.
addpath('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto')
%REFERENCE
img_r=imread('2018.png');
%TARGETS
img_t=imread('2018.png');
img_t2=imread('mosaico1.png');
img_t2=imresize3(img_t2,size(img_r));% Resizes the image

%TRANSFORMING IMAGES TO GRAY SCALE
It2=rgb2gray(img_t2);
It= rgb2gray(img_t); %Target image
Ir=rgb2gray(img_r); %Reference image
figure(1); subplot(2,2,1);imshow(It);sgtitle('Target(L) and Reference(R) images with their shifted FT')
subplot(2,2,2);imshow(Ir);

%FT OF TARGET AND REFERENCE
%Target
Ft=fft2(It);St=abs(Ft);Rt=mat2gray(log(1+St));
Ft_sh=fftshift(Ft);St_sh=abs(Ft_sh);Rt_sh=mat2gray(log(1+St_sh)); %_sh meaning shifted
subplot(2,2,3);imshow(Rt_sh,[]);
%Reference
Fr=fft2(Ir);Sr=abs(Fr);Rr=mat2gray(log(1+Sr));
Fr_sh=fftshift(Fr);Sr_sh=abs(Fr_sh);Rr_sh=mat2gray(log(1+Sr_sh));
subplot(2,2,4);imshow(Rr_sh,[]);

%CONSTRUCTIION OF FILTER- Made form the ref image 
H_CM=conj(Fr); %Classical Match Filter without noise: the complex conjugated of reference's FT.
H_PO=conj(Fr)./abs(conj(Fr)); %Phase Only Filter

%INCLUSION OF FILTER IN FOURIER PLANE-Multiplying filter by Target's FT.
%P=Ft.*H_CM;
P=Ft.*H_PO;

%CORRELATION
c=ifft2(P); %inverse transform of the product mentioned above
C=ifftshift(c);% Shift the result

%SURFACES
pos1 = [0.25 0.44 0.5 0.5];
pos2 = [0.4 0.04 0.3 0.3]; %[left bottom width height]

figure(2);subplot('position',pos1);mesh(log(1+abs(C)));colormap(jet);title('shifted Correlation')
subplot('position',pos2); imagesc(log(1+abs(C)));colormap(jet); colorbar; 
