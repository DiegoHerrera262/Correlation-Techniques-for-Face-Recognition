%VLC CORRELATOR SIMPLE SIMULATION FOR FACE RECOGNITION-using only eyes as ref -LUIS CARLOS DURAN
%Date: 03-05-2020
%This code calculates and shows the result of the correlation function
%between a target and a reference image, using the method of a VLC type architecture and multiple references.
%Here the references are only the eyes and nose of the subjcet, and the target is the face. 
%KEEP IN MIND THAT THE REFERENCES ARE NOW SMALLER THAN THE TARGET
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
img_t=imread('eyes5.png');img_t=imresize3(img_t,size(img_r));% Resizes the image
img_t2=imread('face1.png');img_t2=imresize3(img_t2,size(img_r));% Resizes the image

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
It2=rgb2gray(img_t2);
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

%PARTIAL CORRELATIONS
pc=ifft2(Ft.*Fr);pc2=ifft2(Ft.*Fr2);pc3=ifft2(Ft.*Fr3);pc4=ifft2(Ft.*Fr4);pc5=ifft2(Ft.*Fr5);pc6=ifft2(Ft.*Fr6);
pc7=ifft2(Ft.*Fr7);pc8=ifft2(Ft.*Fr8);pc9=ifft2(Ft.*Fr9);pc10=ifft2(Ft.*Fr10);
%CALCULATING PCE FOR EACH CORRELATION (EXPLAINATION AT THE BUTTOM)
E_plane_ij=abs(ifft2(Ft.*(Fr+Fr2+Fr3+Fr4+Fr5+Fr6+Fr7+Fr8+Fr9+Fr10))).^2; ET_plane=sum(E_plane_ij,'all');                          
ET_peak=[abs(max(pc,[],'all')).^2 abs(max(pc2,[],'all')).^2 abs(max(pc3,[],'all')).^2 abs(max(pc4,[],'all')).^2 abs(max(pc5,[],'all')).^2 abs(max(pc6,[],'all')).^2 abs(max(pc7,[],'all')).^2 abs(max(pc8,[],'all')).^2 abs(max(pc9,[],'all')).^2 abs(max(pc10,[],'all')).^2]
PCE=ET_peak./ET_plane


%CONSTRUCTIION OF COMPOPSITE FILTER 

%coeficients here are arbitrary
%A=[0.2 0.4 0.6 0.8 1.0 1.2]; %coeficients to be used for the filter

%coeficients here are chosen from PCE
a=0.8; %0.5<=a<=1.5
A=(PCE).^(-a)

%H_COM=0;
%for i=1:length(A)
 %   H_COM= H_COM+A(i).*FT_R(i); -THIS "FOR" ISN'T WORKING 
%end
%H_COM;
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

figure(2);subplot('position',pos1);mesh(log(1+abs(C)));colormap(jet);title('shifted Correlation using H_{COM2}')%result using H_COM2
subplot('position',pos2); imagesc(log(1+abs(C)));colormap(jet); colorbar;                    %log needed to scale

figure(3);subplot('position',pos1);mesh(1+abs(C2));colormap(jet);title('shifted Correlation using H_{COM3}')%Result using H_COM3
subplot('position',pos2); imagesc(1+abs(C2));colormap(jet); colorbar;                    %log NOT needed

%PCE (Peak to correlation energy is defined as the energy of the peak correlation
%normalized to the total energy of the correlation plane

%NOW: the instead of energy for this case would be given by |g|^2 where g is the respective function.
%PCE=(\nsum_{i,j}^{N} E_{peak}(i,j))/(\nsum_{i,j}^{M} E_plane(i,j)) %M:
%size of correlation plane and N= Size of peak correlation spot, clearly N<M;

