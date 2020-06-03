%VLC CORRELATOR SIMPLE SIMULATION FOR FACE RECOGNITION IMPROVED 4-LUIS CARLOS DURAN
%Date: 29-05-2020
%This code calculates and shows the result of the correlation function between a target and a reference image, 
%using the method of a VLC type architecture and multiple references(50). A COMPOSITE FILTER prototype is used and 
%coeficients for the linear combination are computed based on a PCE criteria. 
%Code's capacity to perform operations is enhaced thanks to the usage of the function "cell" and the command "for"

%Cell function usage in the code is based on  https://stackoverrun.com/es/q/4399094 AND 
%https://lorena2008.wordpress.com/2012/10/31/leer-multiples-imagenes-de-un-directorio-en-matlab/
%The folder "Sample2" contains 50  Refs. 

%This codes includes one normalization method: Use im2doulble and normalization function imediatly after gray scaling, 
%then use the adjustment function with values [0.07 0.2], perform a new normalization. Then use the imcomplement function.
%Apply the edge detection function with the log standard method and finally new function called "bwlabel"
clear all;
close all;
clc;
clf;
path=addpath('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto\Image_Database\Sample2');
%READING AL PNG FILES
read_files= dir('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto\Image_Database\Sample2\*.png'); 

%READING IMAGES 
%CREATING " REF ARRAY" WHOSE ELEMENTS ARE THE REF IMAGES
%->CELL ARRAY EXPLAINED AT THE END
%REFERENCE SET
img_r=cell(length(read_files),1); %Initialize your cell array so its number of elements is the same number of refs.
for k=1:length(read_files)
photo=read_files(k).name;    
img_r{k}=imread(photo);
img_r{k}=imresize3(img_r{k},size(img_r{1})); %Note that each img_r{k} is a matrix
end
%TEST IMAGE
N=30; %N=Number of the image of the set we want to use
picture=read_files(N).name %This is to watch the name of the image used at the moment
%30=Sample236 (a Bad one); 10=Sample218 (a good one)
img_t=imread(picture);img_t=imresize3(img_t,size(img_r{1}));

%TRANSFORMING IMAGES TO GRAY SCALE
%REFERENCES IMAGES
Ir=cell(length(img_r),1); %Initialize
for k=1:length(img_r) 
Ir{k}=rgb2gray(img_r{k}); %Note that each Ir{k} is a matrix
Ir{k}=im2double(Ir{k}); %Make image a double
Ir{k}=normalize(Ir{k}); %Normalize image 
Ir{k}=imadjust(Ir{k},[0.07 0.2]); %[low_in high_in]
Ir{k}=normalize(Ir{k}); %ReNormalize image
Ir{k}=imcomplement(Ir{k});
Ir{k}=edge(Ir{k},'log');
Ir{k}=bwlabel(Ir{k});
end

%TARGET IMAGES
It= rgb2gray(img_t);It=im2double(It);It=normalize(It);It=imadjust(It,[0.07 0.2]); %[low_in high_in]
It=normalize(It);It=imcomplement(It);It=edge(It,'log');It=bwlabel(It);        

%SHOW IMAGES->NOT USEFUL WHEN THERE'S TOO MANY

%FT OF TARGET AND REFERENCES
%References
Fr=cell(length(Ir),1); %Initialize
for k=1:length(Ir)   
Fr{k}=fft2(Ir{k});      %Note that each Fr{k} is a matrix  
end
%Target
Ft=fft2(It);

%PARTIAL CORRELATIONS
pc=cell(length(Fr),1); %Initialize
for k=1:length(Fr)    
pc{k}=fft2(Ft.*Fr{k});  %Note that each pc{k} is a matrix
end

%CALCULATING PCE FOR EACH CORRELATION
%Remember that things like E_´plane_ij or ET_peak are matrix and a vector
%respectively, therefore here the definition is done like this:
sum_Fr=zeros(size(Fr{1},1),size(Fr{1},2)); %Initializing this matrix to be the same size of the references FT, it will represent the sum of all FT
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


%CONSTRUCTIION OF COMPOPSITE FILTER 
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


%INCLUSION OF FILTER IN FOURIER PLANE-Multiplying filter by Target's FT.
P=Ft.*H_BCOM;

%TOTAL CORRELATION
c=ifft2(P); %inverse transform of the product mentioned above
C=ifftshift(c);% Shift the result for later ploting

%SURFACES
pos1 = [0.25 0.44 0.5 0.5];
pos2 = [0.4 0.04 0.3 0.3]; %[left bottom width height]

subplot('position',pos1);mesh(1+abs(C));colormap(jet);title('Shifted Correlation BCOM filter')%Result using H_BCOM
subplot('position',pos2); imagesc(1+abs(C));colormap(jet); colorbar;                    %log NOT needed

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CELL:
%A cell array is a data type with indexed data containers called cells, 
%where each cell can contain any type of data. Cell arrays commonly contain either lists of text, 
%combinations of text and numbers, or numeric arrays of different sizes. Refer to sets of cells by enclosing 
%indices in smooth parentheses, (). Access the contents of cells by indexing with curly braces, {}.
%When you have data to put into a cell array, create the array using the cell array construction operator, {}.