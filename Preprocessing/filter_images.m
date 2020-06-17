% Program that filters pictures and saves them in current directory
% Date : 30 - 05 - 20
% Author: Andrés Duque Bran
% Description: This program filtered pictures from a selected database using a Wiener filter within 
%              a radius of five pixels and saves them in a new directory.

function filter_images(dirname)
    %% Look for the images
    basedir = pwd();
    Path = strcat(basedir,'/',dirname);
    images = dir(fullfile(Path,'*.png'));
    %% Creates destination folder
    mkdir(strcat(basedir,'/',dirname,'_filtered'))
    address = [basedir '/' dirname '_filtered/' 'filtered_'];
    %% Filters each Image
    for k = 1:length(images)
        RGB = imread(strcat(Path,'/',images(k).name));
        % I = RGB;
        I = rgb2gray(RGB);
        I2 = wiener2(I,[5 5]);
        %figure
        %title(strcat('Image ',num2str(k), ' with Noise Removed by Wiener Filter'));
        %% Save the image
        where = strcat(address,images(k).name);
        imwrite(I2,where);
    end
end
