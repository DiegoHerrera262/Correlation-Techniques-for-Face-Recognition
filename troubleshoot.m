% Program for troubleshooting a sample image
% Date : 24 - 04 - 20
% Author: Diego Alejandro Herrera
% Description: This program is used to check in more detail the
%              correlation output for a pair of images, taking into
%              account the basic image used to sinthesize the
%              filter. Always run it after TrainingPSE.m Never before.

%% Generate the filter Output
% Comment if already ran TrainingPSE.m !!!!
TrainingPSE;

%% Read Test images
% Change the index of the Data element for assesing the output of
% A certain pair of images

dirname = 'Diego_filtered';
% Define name
testnamegood = Data(13).name;
testnamebad = Data(21).name;
% Read images
refimg = imread(char(usedImages(1)));
testimgood = imread([dirname '/' testnamegood]);
testimbad = imread([dirname '/' testnamebad]);

%% Plot Comparative Output
figure(10);
subplot(1,2,1);
planegood = CFxcorr(testimgood,dirname,'MACE');
surf(planegood);
[pse1,location1] = PSE(planegood);
title(['MACE Filter acting on ' testnamegood ...
    ' PSE = ' num2str(pse1)]);
subplot(1,2,2);
planebad = CFxcorr(testimbad,dirname,'MACE');
surf(planebad);
[pse2,location2] = PSE(planebad);
title(['MACE Filter acting on ' testnamebad ...
    ' PSE = ' num2str(pse2)]);

%% Show montage of images
% Add location of peaks
tgoodpeak = insertShape(testimgood,'circle',...
    [location1(2), location1(1), 10],'LineWidth',5);
tbadpeak = insertShape(testimbad,'circle',...
    [location2(2), location2(1), 10],'LineWidth',5);
multi = {tgoodpeak,tbadpeak};
figure(11);
subplot(1,2,1);
imshow(refimg,[]);
title('Reference Image');
subplot(1,2,2);
montage(multi);
title('GoodTest/BadTest');