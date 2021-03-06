%% IMPOSTOR TRIALS FINAL
%Date: 26-06-2020
%Author: LUIS CARLOS DURAN
%Description: This code ONLY calculates the correlation function between a target and a reference image, 
%using the method of a VLC type architecture and multiple references. A BINARY COMPOSITE FILTER prototype is used and 
%coeficients for the linear combination are computed based on a PCE criteria, and they're depenedent on the test image used.
%This code calculates the PCE and PSR values of the total correlation plane
% when the test image is either an impostor, an expected match or belongs
% to the filter construction set.

%RUN THE CODE FOR PSR_OG FUNCTION BEFORE IMPLEMENTING THIS CODE
clear all;
close all;
clc;
%clf;
%Filter set
path=addpath('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto\Image_Database\Filter_Sample2');
%Impostor set
path2=addpath('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto\Impostor3');
%Possible match tests outside the filter
path3=addpath('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto\Image_Database\Test_Sample2');

%% READING ALL PNG FILES
read_files= dir('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto\Image_Database\Filter_Sample2\*.png'); 
read_files2=dir('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto\Impostor3\*.png');
read_files3= dir('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto\Image_Database\Test_Sample2\*.png'); 

%% READING IMAGES 
%REFERENCE SET
img_r=cell(length(read_files),1); %Initialize your cell array so its number of elements is the same number of refs.
for k=1:length(read_files)
photo=read_files(k).name;    
img_r{k}=imread(photo);
img_r{k}=imresize3(img_r{k},size(img_r{1})); %Note that each img_r{k} is a matrix
end
%TEST IMAGE

%Image on the reference set
N=1;Test_picture=read_files(N).name;
%img_t=imread(Test_picture);img_t=imresize3(img_t,size(img_r{1}));

%Impostor Image:
M=4;Impstor_picture=read_files2(M).name;
%img_t=imread(Impstor_picture);img_t=imresize3(img_t,size(img_r{1}));

%True Image but outside the reference set:
L=175;STest_picture=read_files3(L).name;
img_t=imread(STest_picture);img_t=imresize3(img_t,size(img_r{1}));



%% TRANSFORMING IMAGES TO GRAY SCALE
%REFERENCES IMAGES
Ir=cell(length(img_r),1); %Initialize 
for k=1:length(img_r) 
Ir{k}=rgb2gray(img_r{k}); %Note that each Ir{k} is a matrix. 
Ir{k}=imadjust(Ir{k});%,[0.07 0.2]); %[low_in high_in]
Ir{k} = adapthisteq(Ir{k});
Ir{k}=wiener2(Ir{k},[5 5]);
Ir{k}=im2bw(Ir{k},0.4);
Ir{k}=bwlabel(Ir{k});
end
%TARGET IMAGES
It=rgb2gray(img_t);
It=imadjust(It);%,[0.07 0.2]); %[low_in high_in]
It= adapthisteq(It);
It=wiener2(It,[5 5]);
It=im2bw(It,0.4);
It=bwlabel(It);  

%% FT OF TARGET AND REFERENCES
%References
Fr=cell(length(Ir),1); %Initialize
for k=1:length(Ir)   
Fr{k}=fft2(Ir{k});      %Note that each Fr{k} is a matrix  
end
%Target
Ft=fft2(It);

%% PARTIAL CORRELATIONS
pc=cell(length(Fr),1); %Initialize
for k=1:length(Fr)    
pc{k}=ifft2(Ft.*Fr{k});  %Note that each pc{k} is a matrix
end

%% CALCULATING PCE FOR EACH CORRELATION
%Remember that things like E_´plane_ij or ET_peak are matrix and a vector
%respectively, therefore here the definition is done like this:
sum_Fr=zeros(size(Fr{1},1),size(Fr{1},2)); %Initializing this matrix to be the same size of the references FT, 
%it will represent the sum of all References FT
for k=1:length(Fr)    
sum_Fr=sum_Fr+Fr{k};     %Note that sum_Fr is a matrix by definition
end
E_plane_ij=abs(ifft2(Ft.*sum_Fr)).^2; %Corr plane energy for the ij spot -> a matrix
ET_plane=sum(E_plane_ij,'all'); %corr plane total energy
       
ET_peak=zeros(1,length(pc)); %initializing Peak energy vector
for k=1:length(pc)    
ET_peak(k)=abs(max(pc{k},[],'all')).^2; %Note that E_peak is a vector by definition
end
ET_peak; %Contains energy for each peak
PCE=ET_peak./ET_plane; % Contains PCE for each peak -> a vector

%% CONSTRUCTIION OF COMPOPSITE FILTER 
%coeficients here are chosen from PCE
a=0.8; %0.5<=a<=1.5
A=(PCE).^(-a);
%Doing the linear comb with a for
H_COM=zeros(size(Fr{1},1),size(Fr{1},2)); %initializing this matrix to be  the same size of the references FT;
for k=1:length(A)
    H_COM= H_COM+A(k).*Fr{k}; 
end
H_COM; %COM filter defined
H_BCOM=sign(real(H_COM)); %BINARY COM filter constructed from H_COM


%% INCLUSION OF FILTER IN FOURIER PLANE-Multiplying filter by Target's FT.
P=Ft.*H_BCOM;

%% TOTAL CORRELATION
c=ifft2(P); %inverse transform of the product mentioned above
C=ifftshift(c);% Shift the result for later ploting

%% SURFACES
pos1 = [0.25 0.44 0.5 0.5];
pos2 = [0.4 0.04 0.3 0.3]; %[left bottom width height]

%subplot('position',pos1);mesh(1+abs(C));colormap(jet);title('Shifted Correlation BCOM filter')%Result using H_BCOM
%subplot('position',pos2); imagesc(1+abs(C));colormap(jet); colorbar;                    %log NOT needed

%figure(2);imshow(It);title('Test image (Edge detection + Label function)');

%% Calculating PCE and PSR for the actual correlation plane 
%Because before we calculated this value for the "partial correlations" in order to find the coeficients A(k)
Peak_energy=abs(max(C,[],'all')).^2;
Plane_energy=sum(abs(C).^2,'all');
PCE_TOT=Peak_energy/Plane_energy

%implement PSE function for the next command to work
PSR_TOT=PSR_OG(C)
