%% Program that takes pictures and saves them in current directory
% Date : 24 - 04 - 20
% Author: Diego Alejandro Herrera
% Description: This program takes pictures from webcam, and saves them in a
%              folder in the currend address. Rectangle must have the
%              following format [xsupleft,ysupleft,width,height]
%              Suggested values width = 175, height = 207
%                               xsupleft = 552, ysupleft = 0
%              Proportions taken at a perpendicular distance of ~3.5cm
%              from the camera.

function acquire_data(num_samples,cam,dirname,type)
    %% Define cropping rectangle easily
    % Get Camera resolution
    resol = cam.resolution;
    dims = split(resol,'x');
    w = str2double(cell2mat(dims(1)));
    h = str2double(cell2mat(dims(2)));
    % Compute coordinates of region of interest
    width = uint16(0.2397*w); height = uint16(0.370*h);
    xcorn = uint16(0.3640*w); ycorn = uint16(0.3253*h);
    % Define rectangele vector
    rectange = [xcorn, ycorn, width, height];
    % Alignment lines
    Vline = [xcorn + uint16(width/2) ycorn ...
        xcorn + uint16(width/2) ycorn + height];
    Hline = [xcorn ycorn + uint16(height/2) ...
        xcorn + uint16(width)  ycorn + uint16(height/2)];
    %% This sets the direction for image saving
    mkdir(dirname)
    basedir = pwd();
    address = [basedir '/' dirname '/' type];
    i = 1;
    %% This while captures snapshots and saves suitedly cropped images
    clear y;
    while i < num_samples
        img = snapshot(cam);
        dispImag = insertShape(img,'Rectangle',rectange,...
            'LineWidth',5,'Color','g');
        dispImag = insertShape(dispImag,'Line',Vline,...
            'LineWidth',3,'Color','g');
        dispImag = insertShape(dispImag,'Line',Hline,...
            'LineWidth',3,'Color','g');
        imshow(dispImag);
        y = input('Ready to take sample? (1/0): ');
        if y == 1
            where = [address num2str(i) '.png'];
            data_img = imcrop(img,rectange);
            imwrite(data_img,where);
            i = i+1;
        end
    end
end