%% ROC CURVES 
%Date: 26-06-2020
%Author: LUIS CARLOS DURAN
%Description: This code Plots the ROC curves, a TPR vs FNR curve and a
%FNR/TPR againts the fraction of std used to form the acceptance region
%for a test set of images and using both preprocessing methods.

clear all;close all;clc;clf;
N=40;M=40; %N= Expected positives; %M= Expected negatives

%% 1) PREPROCESSING METHOD 1.
%True_PSE_mean=11.9632 ;
True_PSE_STD= 1.6248;
% False_PSE_mean= ;   %ORIGINAL MATCH BAND:[];
%False_PSE_STD = ;

%The match bands are taken in this way: [mean-c*std,mean+c*std] where c is
%a constant and takes the values: 0.2-3.6 inreasing in steps of 0.2

TPR=1/N.*[26 27 28 32 33 34 36 38 39 39 39 39 40 40 40 40 40 40]; %TRUE POSITIVES RATE 
FNR=1/N*[14 13 12 8 7 6 4 2 1 1 1 1 0 0 0 0 0 0]; %FALSE NEGATIVES RATE
figure(1);plot(FNR,TPR,'.-b');%hold on;fplot('1-x',[0,1],'--r');hold off;
xlabel('FNR');ylabel('TPR');title('ROC curve (Preprocessing 1)');grid on

%% 2) PREPROCESSING METHOD 2.
%True_PSE_mean_2= 11.9721;
True_PSE_STD_2= 1.4759;
%False_PSE_mean_2= ;  OG Match region = []; 
%False_PSE_STD_2 = ;

%The match bands are taken in this way: [mean-c*std,mean+c*std] where c is
%a constant and takes the values: 0.2-3.6 inreasing in steps of 0.2

TPR_2=1/N.*[25 28 30 32 33 33 36 38 38 39 39 39 40 40 40 40 40 40];%TRUE POSITIVES RATE
FNR_2=1/N*[15 12 10 8 7 7 4 2 2 1 1 1 0 0 0 0 0 0]; %FALSE NEGATIVES RATE
figure(2);plot(FNR_2,TPR_2,'.-b');%hold on;fplot('1-x',[0,1],'--r');hold off;
xlabel('FNR');ylabel('TPR');title('ROC curve (Preprocessing 2)');grid on


%% 3)CURVES RESPECT TO Percentage of std used on the region size.
%5.1)Method 1
y=0.2:0.2:3.6;
ratio1=FNR./TPR;
figure(3);plot(y,FNR./TPR);xlabel('STD fraction');ylabel('FNR / TPR');title('FNR, TPR ratio V std fraction used on match region(Preprocessing 1)');grid on
%5.2) Method 2
ratio2=FNR_2./TPR_2;
figure(4);plot(y,FNR_2./TPR_2);xlabel('STD fraction');ylabel('FNR / TPR');title('FNR, TPR ratio V std fraction used on match region(Preprocessing 2)');grid on

%% False positives vs Truee Positives
%TPR=1/N.*[]; %TRUE POSITIVES RATE 
%FPR=1/M.*[]; %FALSE POSITIVES RATE
%figure(1);plot(FPR,TPR,'.-b');hold on;fplot('1-x',[0,1],'--r');hold off;
%xlabel('FPR');ylabel('TPR');title('ROC curve (Preprocessing 1)');grid on
