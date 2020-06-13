% Program that corrects pictures and saves them in current directory
% Date : 3 - 05 - 20
% Author: Andrés Duque Bran
% Description: This program corrects pictures from a selected database by removing 
%              background and readjusting contrastand saves them in a new directory.

function correct_images(dirname)
    %% Look for the images
    basedir = pwd();
    Path = strcat(basedir,'/',dirname);
    images = dir(fullfile(Path,'*.png'));
    %% Creates destination folder
    mkdir(strcat(basedir,'/',dirname,'_corrected'))
    address = [basedir '/' dirname '_corrected/' 'corrected_sample'];
    %% Filters each Image
    for k = 1:length(images)
        RGB = imread(strcat(Path,'/',images(k).name));
        I = rgb2gray(RGB);
        se = strel('disk',70);
        background = imopen(I,se);
        I2 = I - background;
        I3 = imadjust(I2);
        %figure
        %title(strcat('Image ',num2str(k), ' with Noise Removed by Wiener Filter'));
        %% Save the image
        where = [strcat(address,num2str(k),'.png')];
        imwrite(I3,where);
    end
end

