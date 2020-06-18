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
        I2 = wiener2(I,[5 5]);
        % Save the image
        where = [address 'filtered_' images(k).name];
        imwrite(I2,where);
    end
end
