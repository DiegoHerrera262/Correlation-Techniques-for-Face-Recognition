% Program that enhances pictures and saves them in current directory
% Date : 27 - 05 - 20
% Author: Andrés Duque Bran
% Description: This program enhances pictures from a selected database and
%              saves them in a new directory.

function enhance_images(dirname)
    %% Look for the images
    basedir = pwd();
    Path = strcat(basedir,'/',dirname);
    images = dir(fullfile(Path,'*.png'));
    %% Creates destination folder
    mkdir(strcat(basedir,'/',dirname,'_enhanced'))
    address = [basedir '/' dirname '_enhanced/' 'enhanced_sample'];
    %% Enhances each Image
    for k = 1:length(images)
        RGB = imread(strcat(Path,'/',images(k).name));
        I = rgb2gray(RGB);
        imwrite(I,'sample.tif');
        I1 = imadjust(I);
        I2 = histeq(I1);
        I3 = adapthisteq(I2);
        %figure
        %title(strcat('Enhanced Image ',num2str(k)));
        %% Save the image
        where = [strcat(address,num2str(k),'.png')];
        imwrite(I3,where);
    end
end

