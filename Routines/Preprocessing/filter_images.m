% Program that filters pictures and saves them in current directory
% Date : 30 - 05 - 20
% Author: Andrés Duque Bran
% Description: This program filtered pictures from a selected database using a Wiener filter within 
%              a radius of five pixels and saves them in a new directory.

function filter_images(dirname)
    %% Look for the images
    Path = [pwd() '/RawDatabase/' dirname];
    images = dir(fullfile(Path,'*sample*.png'));
    
    %% Creates destination folder
    imdir = [pwd() '/ProcessedDatabase'];
    address = [imdir '/' dirname '_filtered/'];
    if ~exist(address, 'dir')
       mkdir(address)
    end
    
    %% Filters each Image
    for k = 1:length(images)
        cond = (strcmp(images(k).name,'.') | ... 
            strcmp(images(k).name,'..')) | ...
            contains(images(k).name,'._');
        if ~cond 
            RGB = imread(strcat(Path,'/',images(k).name));
            I = rgb2gray(RGB);
            I = wiener2(I,[5 5]);
            I = log(double(I)+1);
            I = mat2gray(I);
            % Save the image
            where = [address 'filtered_' images(k).name];
            imwrite(I,where);
        end
    end
end
