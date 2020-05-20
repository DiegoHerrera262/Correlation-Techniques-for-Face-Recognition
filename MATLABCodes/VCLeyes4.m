%VLC CORRELATOR SIMPLE SIMULATION FOR FACE RECOGNITION-using only eyes as ref 4-LUIS CARLOS DURAN
%Date: 08-05-2020
%This code calculates and shows the result of the correlation function
%between a target and a reference image, using the method of a VLC type architecture and a multiple references(10).
%Here the references are only the eyes and nose of the subjcet, and the target is the face. Also since
%the references are now smaller than the target, we ADD ZEROS to the references to solve this problem
%HERE THE ZEROS ARE ADDED TO THE FT MATRICES
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
img_r2=imread('eeyes2.png');img_r2=imresize3(img_r2,size(img_r));
img_r3=imread('eeyes3.png');img_r3=imresize3(img_r3,size(img_r));
img_r4=imread('eeyes4.png');img_r4=imresize3(img_r4,size(img_r));
img_r5=imread('eeyes5.png');img_r5=imresize3(img_r5,size(img_r));
img_r6=imread('eeyes6.png');img_r6=imresize3(img_r6,size(img_r));
img_r7=imread('eeyes7.png');img_r7=imresize3(img_r7,size(img_r));
img_r8=imread('eeyes8.png');img_r8=imresize3(img_r8,size(img_r));
img_r9=imread('eeyes9.png');img_r9=imresize3(img_r9,size(img_r));
img_r10=imread('eeyes10.png');img_r10=imresize3(img_r10,size(img_r));

%TEST IMAGES
img_t=imread('eyes1.png');
%TRANSFORMING IMAGES TO GRAY SCALE
%REFERENCE IMAGES:
Ir=rgb2gray(img_r); 
Ir2=rgb2gray(img_r2);
Ir3=rgb2gray(img_r3);
Ir4=rgb2gray(img_r4);
Ir5=rgb2gray(img_r5);
Ir6=rgb2gray(img_r6);
Ir7=rgb2gray(img_r7);
Ir8=rgb2gray(img_r8);
Ir9=rgb2gray(img_r9);
Ir10=rgb2gray(img_r10);
%TARGET IMAGES:
It= rgb2gray(img_t); %Target image

%SHOW IMAGES
figure(1);subplot(4,3,1);imshow(Ir);subplot(4,3,2);imshow(Ir2);subplot(4,3,3);imshow(Ir3); sgtitle('References and target(Center)')
subplot(4,3,4);imshow(Ir4);subplot(4,3,6);imshow(Ir5);subplot(4,3,7);imshow(Ir6);subplot(4,3,9);imshow(Ir7);
subplot(4,3,10);imshow(Ir8);subplot(4,3,11);imshow(Ir9);subplot(4,3,12);imshow(Ir10);subplot(4,3,[5;8]);imshow(It);

%FT OF TARGET AND REFERENCES
%References
Fr=fft2(Ir);Fr2=fft2(Ir2);Fr3=fft2(Ir3);Fr4=fft2(Ir4);Fr5=fft2(Ir5);
Fr6=fft2(Ir6);Fr7=fft2(Ir7);Fr8=fft2(Ir8);Fr9=fft2(Ir9);Fr10=fft2(Ir10);
%Target
Ft=fft2(It);

%SHIFT THE FT FOR LATER PLOT OF THEIR MAGNITUDES
%References
Fr_sh=fftshift(Fr);Fr2_sh=fftshift(Fr2);Fr3_sh=fftshift(Fr3);Fr4_sh=fftshift(Fr4);Fr5_sh=fftshift(Fr5);
Fr6_sh=fftshift(Fr6);Fr7_sh=fftshift(Fr7);Fr8_sh=fftshift(Fr8);Fr9_sh=fftshift(Fr9);Fr10_sh=fftshift(Fr10);
%Target
Ft_sh=fftshift(Ft);
%SHOW FOURIER SPECTRUMS
figure(2);subplot(4,3,1);imshow(Fr_sh);subplot(4,3,2);imshow(Fr2_sh);subplot(4,3,3);imshow(Fr3_sh); sgtitle('Shifted Re[FT] of References and target(Center)')
subplot(4,3,4);imshow(Fr4_sh);subplot(4,3,6);imshow(Fr5_sh);subplot(4,3,7);imshow(Fr6_sh);subplot(4,3,9);imshow(Fr7_sh);
subplot(4,3,10);imshow(Fr8_sh);subplot(4,3,11);imshow(Fr9_sh);subplot(4,3,12);imshow(Fr10_sh);subplot(4,3,[5;8]);imshow(Ft_sh);
%SHOW |FT|
figure(3);subplot(4,3,1);imagesc(log(abs(Fr_sh)+1));subplot(4,3,2);imagesc(log(abs(Fr2_sh)+1));sgtitle('Shifted |FT| of References and target(Center)')
subplot(4,3,1);imagesc(log(abs(Fr_sh)+1));subplot(4,3,2);imagesc(log(abs(Fr2_sh)+1));
subplot(4,3,3);imagesc(log(abs(Fr3_sh)+1));subplot(4,3,4);imagesc(log(abs(Fr4_sh)+1));
subplot(4,3,6);imagesc(log(abs(Fr5_sh)+1));subplot(4,3,7);imagesc(log(abs(Fr6_sh)+1));
subplot(4,3,9);imagesc(log(abs(Fr7_sh)+1));subplot(4,3,10);imagesc(log(abs(Fr8_sh)+1));
subplot(4,3,11);imagesc(log(abs(Fr9_sh)+1));subplot(4,3,12);imagesc(log(abs(Fr10_sh)+1));
subplot(4,3,[5;8]);imagesc(log(abs(Ft_sh)+1));

%FIXING SIZES
%Create i,j 
i=(size(Ft,1)-size(Fr,1))./2;j=(size(Ft,2)-size(Fr,2))./2; 
%i and j are the number of rows and colums (containing zeros) that must be added to the matrices 
%corresponding to the references. The idea is to add the zeros around such matrices, 
%so that their FT sizes coincide with the target's FT. NOTE that these i,j values work for all references 
%since they do have the same size (the references)

%Padarray a number around matrix, only works for image toolbox.
Fr= padarray(Fr,[i j],0);Fr2= padarray(Fr2,[i j],0); Fr3= padarray(Fr3,[i j],0); Fr4= padarray(Fr4,[i j],0); Fr5= padarray(Fr5,[i j],0); 
Fr6= padarray(Fr6,[i j],0); Fr7= padarray(Fr7,[i j],0); Fr8= padarray(Fr8,[i j],0); Fr9= padarray(Fr9,[i j],0); Fr10= padarray(Fr10,[i j],0); 

%THIS ONLY WOULD BE TO SEE HOW ARE THE SHIFTED |FT| NOW THAT WE ADDED THE ZEROS
%Fr_sh=padarray(Fr_sh,[i j],0);Fr2_sh=padarray(Fr2_sh,[i j],0);Fr3_sh=padarray(Fr3_sh,[i j],0);Fr4_sh=padarray(Fr4_sh,[i j],0);
%Fr5_sh=padarray(Fr5_sh,[i j],0);Fr6_sh=padarray(Fr6_sh,[i j],0);Fr7_sh=padarray(Fr7_sh,[i j],0);Fr8_sh=padarray(Fr8_sh,[i j],0);
%Fr9_sh=padarray(Fr9_sh,[i j],0);Fr10_sh=padarray(Fr10_sh,[i j],0);%Since Ft and Ft_sh have the same size this works here

%PARTIAL CORRELATIONS
pc=ifft2(Ft.*Fr);pc2=ifft2(Ft.*Fr2);pc3=ifft2(Ft.*Fr3);pc4=ifft2(Ft.*Fr4);pc5=ifft2(Ft.*Fr5);pc6=ifft2(Ft.*Fr6);
pc7=ifft2(Ft.*Fr7);pc8=ifft2(Ft.*Fr8);pc9=ifft2(Ft.*Fr9);pc10=ifft2(Ft.*Fr10);

%CALCULATING PCE FOR EACH CORRELATION (EXPLAINATION AT THE BUTTOM)
E_plane_ij=abs(ifft2(Ft.*Fr)).^2; ET_plane=sum(E_plane_ij,'all')                          
ET_peak=[abs(max(pc,[],'all')).^2 abs(max(pc2,[],'all')).^2 abs(max(pc3,[],'all')).^2 abs(max(pc4,[],'all')).^2 abs(max(pc5,[],'all')).^2 abs(max(pc6,[],'all')).^2 abs(max(pc7,[],'all')).^2 abs(max(pc8,[],'all')).^2 abs(max(pc9,[],'all')).^2 abs(max(pc10,[],'all')).^2]
PCE=ET_peak./ET_plane


%CONSTRUCTIION OF COMPOPSITE FILTER 
a=0.8; %0.5<=a<=1.5
A=(PCE).^(-a)

H_COM2=Fr.*A(1)+Fr2.*A(2)+Fr3.*A(3)+Fr4.*A(4)+Fr5.*A(5)+Fr6.*A(6)+Fr7.*A(7)+Fr8.*A(8)+Fr9.*A(9)+Fr10.*A(10); %COM filter constructed in a rustic way
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