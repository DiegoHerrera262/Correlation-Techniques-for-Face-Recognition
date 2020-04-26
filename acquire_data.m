% Program that takes pictures and saves them in current directory
% Date : 24 - 04 - 20
% Author: Diego Alejandro Herrera
% Description: This program takes pictures from webcam, and saves them in a
%              folder in the currend address.

function acquire_data(num_samples,cam,rectange,dirname)
    % This sets the direction for image saving
    mkdir(dirname)
    basedir = pwd();
    address = [basedir '/' dirname '/' 'sample'];
    % This for loop captures snapshots and saves suitedly cropped images
    for i = 1:num_samples
        where = [address num2str(i) '.png'];
        img = snapshot(cam);
        % imshow(insertShape(img,'Rectangle',rectange,'LineWidth',5));
        data_img = imcrop(img,rectange);
        imwrite(data_img,where);
    end
end