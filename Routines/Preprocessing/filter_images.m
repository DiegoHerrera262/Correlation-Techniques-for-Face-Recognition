% Program that filters pictures and saves them in current directory
% Date : 30 - 05 - 20
% Author: Andrés Duque Bran
% Description: This program filtered pictures from a selected database using a Wiener filter within 
%              a radius of five pixels and saves them in a new directory.

function filter_images(dirname)
    %% Look for the images
    Path = [pwd() '/RawDatabase/' dirname];
    images = dir(fullfile(Path,'/*sample*.png'));
    
    %% Creates destination folder
    imdir = [pwd() '/ProcessedDatabase'];
    address = [imdir '/' dirname '_filtered/'];
    mkdir(address);
    
    %% Filters each Image
    for k = 1:length(images)
        RGB = imread(strcat(Path,'/',images(k).name));
        I = rgb2gray(RGB);
        I1 = imadjust(I);
        I2 = histeq(I1);
        I3 = adapthisteq(I2);  
        I4 = wiener2(I3,[5 5]);
        % Save the image
        where = [address 'filtered_' images(k).name];
        imwrite(I4,where);
    end
end
