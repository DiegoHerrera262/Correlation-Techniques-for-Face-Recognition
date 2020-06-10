%Ploting of PSE and PCE values
%These plots are for the first form of calculating the values, that is 
% you select a test image (either impostor or an actual ref) and calculate
% these values for the TOTAL correlation plane, then you do the same for another test and so on. 
clear all;
close all;
clf; clc;
path=addpath('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto\Image_Database\Sample4');
path2=addpath('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto\Impostor3');
%READING AL PNG FILES
read_files= dir('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto\Image_Database\Sample4\*.png'); 
read_files2= dir('C:\Users\Lucho xD\Desktop\Eighth Semester\Measures in Optics and Acoustics\Idea 1 proyecto\Impostor3\*.png'); 

%x=1:length(read_files2);
x=1:40;
%%%%%%%%%%%%%%%%%%%%%%%%
%PCE PLOTS
PCE_ref_values=[0.0049 0.0053 0.0058 0.0059 0.0068 0.0076 0.0082 0.0054 0.0061 0.0054 0.0058 0.0044 0.0070 0.0073 0.0106 0.0057 0.0051 0.0050 0.0069 0.0065 0.0055 0.0066 0.0076 0.0028 0.0089 0.0071 0.0086 0.0121 0.0054 0.0065 0.0084 0.0062 0.0082 0.0078 0.0041 0.0059 0.0054 0.0057 0.0074 0.0069];
PCE_false_values=[0.0015 0.0013 0.0011 0.0025 0.0014 0.0020 0.0012 0.0021 0.0015 0.0023 0.0013 9.3971e-04 0.0016 0.0013 0.0013 0.0015 0.0013 0.0016 0.0020 0.0021 0.0012  0.0013 0.0011 0.0014 0.0016 0.0017 0.0019 0.0015 0.0017 8.7534e-04 0.0016 0.0015 0.0015 0.0011 0.0013 0.0014 0.0015 0.0019 0.0013 0.0016];%Impostor 3
figure(1);plot(x,PCE_ref_values,'*-b',x,PCE_false_values,'+-r')
xlabel('Figure Number')
ylabel('PCE')
title('PCE References vs Impostors')
legend('PCE Reference','PCE Impostor') 
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PSE PLOTS

%PSE_ref_values=[6.5395 6.9235 6.8435 7.0768 7.3768 8.1241 7.6047 6.4640 6.8486 6.3922 6.5485 5.9925 7.3260 7.6241 9.2054 7.4717 7.2875 7.2493 8.1298 7.4196 7.7415 7.7461 7.9330 5.0018 8.7519 7.5464 8.0134 9.8108 6.6494 7.3350];
%PSE_false_values=[3.9713 4.2585 4.3280 4.9388 4.1446 4.0861 3.6568 5.0613 4.2929 4.9459 0 3.2388 3.8155 4.3575 4.5035 4.1064 4.1399 4.4890 4.2934 5.0995 3.6809 3.8815 3.6916 4.0841 4.7686 4.3317 5.3885 3.9536 4.1823 3.0945];%Impostor3

PSE_ref_values=[12.6470 9.6195 11.1432 11.3163 12.1510 12.8797 13.2552 10.7740 11.4426 10.7339 11.1421 12.2648 8.7213 12.5130 15.0380 11.1500 10.5369 10.4581 12.2304 11.8311 11.0248 11.9045 12.7478 7.7272 13.9015 12.4124 13.5637 16.1859 10.7173 11.8346 13.4034 11.5135 13.2270 12.9814 9.3305 11.2120 10.7107 11.0380 12.6521 12.1089];
PSE_false_values=[5.4798 5.2094 4.7303 7.1636 5.3599 6.2784 5.0116 6.7104 5.5588 6.8813 5.0775 4.4092 5.5483 5.2586 5.0266 5.6914 5.2122 5.7265 6.3560 6.6407 4.9468 4.9677 4.8940 5.2124 5.8992 5.9736 6.4407 5.4471 5.9355 4.1912 5.8090 5.6559 5.4671 4.7189 5.2266 5.4355 5.6492 6.1659 5.1010 5.7643];%Impostor3
x2=1:40;
figure(2);plot(x2,PSE_ref_values,'-*b',x2,PSE_false_values,'+-r')
xlabel('Figure Number')
ylabel('PSE')
title('PSE References vs Impostors')
legend('PSE References','PSE Impostors')
grid on