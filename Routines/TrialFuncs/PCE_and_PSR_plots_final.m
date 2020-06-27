%% PCE and PSR plots
%Date: 26-06-2020
%Author: LUIS CARLOS DURAN
%Description: This code PlotS the PSR and PCE values (previously
%calculated) of a test set of images.
%The form of calculating the values is: 
% you select a test image (One expected to be a match) and calculate
% these values for the TOTAL correlation plane, then you do the same for another test and so on. 
clear all;
close all;
clf; clc;
x=1:40;

%% PCE PLOTS
%First group of samples: Filter:Sample4 Training:images 1,10-13,100-134.
%PCE_ref_values=[0.0081 0.0047 0.0078 0.0057 0.0072 0.0082 0.0078 0.0056 0.0059 0.0051 0.0057 0.0069 0.0045 0.0066 0.0092 0.0052 0.0057 0.0054 0.0074 0.0067 0.0057 0.0068 0.0082 0.0030 0.0101 0.0071 0.0086 0.0105 0.0048 0.0056 0.0080 0.0061 0.0079 0.0068 0.0044 0.0053 0.0045 0.0055 0.0074 0.0073];
%PCE_false_values=[0.0012 0.0014 9.2980e-04 0.0024 0.0011 0.0016 0.0016 0.0023 0.0014 0.0019 0.0011 9.4425e-04 0.0014 0.0011 0.0018 0.0016 0.0014 0.0017 0.0022 0.0019 0.0012 0.0013 8.6811e-04 0.0011 0.0017 0.0015 0.0018 0.0013 0.0019 7.9595e-04 0.0014 0.0016 0.0015 0.0013 0.0011 0.0013 0.0013 0.0014 0.0013 0.0017];%Impostor 3
%Second group of samples: Filter: Filter_Sample Training:Training_Sample.

%figure(1);plot(x,PCE_ref_values,'*-b',x,PCE_false_values,'+-r')
%xlabel('Figure Number')
%ylabel('PCE')
%title('PCE References vs Impostors')
%legend('PCE Reference','PCE Impostor') 
%grid on

%% PSR PLOTS
x2=1:40;
%First group of samples: Filter:Sample4 Training:images 1,10-13,100-134.
%PSR_ref_values=[13.2576 9.9479 12.8733 11.1341 12.5071 13.3633 12.8535 10.9390 11.1995 10.4794 11.0600 12.2287 9.6475 11.9196 14.0866 10.7452 11.1884 10.8905 12.6944 11.9887 11.1854 12.1385 13.3601 8.0002 14.8365 12.3879 13.5493 15.1220 10.1726 11.0043 12.9960 11.3737 12.9701 12.0791 9.7044 10.6490 9.7661 10.8091 12.6285 12.5211];
%PSR_false_values=[5.0506 5.3544 4.4184 7.0646 4.8291 5.6855 5.7312 7.0180 5.3196 6.1872 4.7504 4.4018 5.1114 4.7489 5.9371 5.8287 5.2497 5.9671 6.7408 6.2559 4.9627 5.1136 4.3888 4.8125 5.8224 5.6453 6.1892 5.0859 6.1622 3.9638 5.3490 5.7146 5.5162 5.1620 4.6307 5.1122 5.2178 5.3571 5.1660 5.8167];%Impostor3

%Second group of samples: Filter: Filter_Sample Training:Training_Sample.
%PSR_ref_values=[13.2576 12.8535 10.9390 11.1995 10.4794 11.0600 12.2287 11.9196 14.0866 10.7452 11.1884 9.9479 10.8905 12.6944 11.9887 11.1854 12.1385 13.3601 14.8365 12.3879 13.5493 15.1220 9.6475 10.1726 11.0043 12.9960 11.3737 12.9701 12.0791 10.6490 9.7661 10.8091 12.6285 8.0002 12.5211 9.7044 12.8733 11.1341 12.5071 13.3633];
PSR_ref_values=[12.3491 13.4611 11.7979 12.0916 11.5290 12.3338 14.1796 12.1859 12.8546 11.5379 10.7186 9.7941 9.7541 12.6883 12.7022 12.1322 10.9806 13.1959 12.4375 12.9542 15.1212 13.8877 9.9901 10.0219 10.9153 11.7676 12.0832 13.6288 12.1773 10.0512 11.3578 11.5238 13.7993 8.3557 12.8999 9.1545 12.1337 11.2221 13.5891 13.5238];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%PSR MEAN AND STD

Band_center_PSR_True= mean(PSR_ref_values)
Band_width_PSR_True= std(PSR_ref_values)
%Band_center_PSR_False= mean(PSE_false_values)
%Band_width_PSR_False= std(PSE_false_values)

True_min=(Band_center_PSR_True-0.6*Band_width_PSR_True)*ones(1,length(x2)); 
%True_max=(Band_center_PSR_True+0.6*Band_width_PSR_True)*ones(1,length(x2));
%False_min=(Band_center_PSR_False-0.6*Band_width_PSR_False)*ones(1,length(x2));
%False_max=(Band_center_PSR_False+0.6*Band_width_PSR_False)*ones(1,length(x2));

figure(1);plot(x2,PSR_ref_values,'-*b')%,x2,PSR_false_values,'+-r');
hold on;
plot(x2,True_min,'--g')%,x2,True_max,'--g',x2,False_min,'--k',x2,False_max,'--k');
hold off;
xlabel('Figure Number')
ylabel('PSR')
title('PSR Plot')%References vs Impostors')
axis([0 length(x2) 7 16])
%legend('PSR References','PSR Impostors')
grid on
