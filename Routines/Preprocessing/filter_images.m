% Program that filters pictures and saves them in current directory
% Date : 30 - 05 - 20
% Author: AndrÃ©s Duque Bran
% Description: This program filtered pictures from a selected database using a Wiener filter within 
%              a radius of five pixels and saves them in a new directory.

function filter_images(dirname)sí
    %% Look for the images
    Path = [pwd() '/RawDatabase/' dirname];
    images = dir(fullfile(Path,'*sample*.png'));
    
    %% Creates destination folder
    imdir = [pwd() '/ProcessedDatabase'];
    address = [imdir '/' dirname '_filtered/'];
    mkdir(address);
    
    %% Filters each Image
    for k = 1:length(images)
        cond = (strcmp(images(k).name,'.') | ... 
            strcmp(images(k).name,'..')) | ...
            contains(images(k).name,'._');
        if ~cond 
            RGB = imread(strcat(Path,'/',images(k).name));
            I = rgb2gray(RGB);
            % I = imadjust(I);
            % I1 = histeq(I1);
            % I2 = adapthisteq(I1);  
            I4 = wiener2(I,[5 5]);
            % I4 = imbinarize(I,0.4);          % Binarize image
            % Save the image
            where = [address 'filtered_' images(k).name];
            imwrite(I4,where);
        end
    end
end
