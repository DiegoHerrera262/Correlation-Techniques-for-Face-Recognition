%% Program that takes pictures and saves them in current directory
% Date : 24 - 04 - 20
% Author: Diego Alejandro Herrera
% Description: This program takes pictures from webcam, and saves them in a
%              folder in the currend address. Rectangle must have the
%              following format [xsupleft,ysupleft,width,height]
%              Suggested values width = 175, height = 207
%                               xsupleft = 552, ysupleft = 0

function acquire_data(num_samples,cam,rectange,dirname)
    clear y;
    % This sets the direction for image saving
    mkdir(dirname)
    basedir = pwd();
    address = [basedir '/' dirname '/' 'false'];
    i = 1;
    % This for while captures snapshots and saves suitedly cropped images
    while i < num_samples
        img = snapshot(cam);
        imshow(insertShape(img,'Rectangle',rectange,'LineWidth',5));
        y = input('Ready to take sample? (1/0): ');
        if y == 1
            where = [address num2str(i) '.png'];
            data_img = imcrop(img,rectange);
            imwrite(data_img,where);
            i = i+1;
        end
    end
end