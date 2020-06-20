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

function acquire_data(num_samples,cam,dirname)
    %% Define cropping rectangle easily
    % Get Camera resolution
    resol = cam.resolution;
    dims = split(resol,'x');
    w = str2double(cell2mat(dims(1)));
    h = str2double(cell2mat(dims(2)));
    width = uint16(0.2397*w); height = uint16(0.370*h);
    xcornLS = uint16(0.3640*w); ycornLS = uint16(0.3253*h);
    
    %% Compute coordinates of region of interest
    % For the sqare border
    xcornRS = xcornLS + width; ycornRS = ycornLS;
    xcornRI = xcornLS + width; ycornRI = ycornLS + height;
    xcornLI = xcornLS; ycornLI = ycornLS + height;
    % For the target
    xVlineS = uint16((xcornRS + xcornLS)/2);
    yVlineS = ycornLS;
    xVlineI = uint16((xcornRI + xcornLI)/2);
    yVlineI = ycornLI;
    yHlineS = uint16((ycornLS + ycornLI)/2);
    xHlineS = xcornLS;
    yHlineI = uint16((ycornRS + ycornRI)/2);
    xHlineI = xcornRS;
    
    %% Define rectangle vector
    rectange = [xcornLS, ycornLS, width, height];
    % Alignment lines
    Vline = [xVlineS yVlineS xVlineI yVlineI];
    Hline = [xHlineS yHlineS xHlineI yHlineI];
    
    %% This sets the direction for image saving
    dirpath = [pwd() '/' 'RawDatabase' '/' dirname];
    mkdir(dirpath);
    address = [dirpath '/sample' ];
    i = 1;
    
    %% This while captures snapshots and saves suitedly cropped images
    set(gcf,'CurrentCharacter','@');            % set to a dummy character
    while i <= num_samples
        img = snapshot(cam);
        dispImag = insertShape(img,'Rectangle',rectange,...
            'LineWidth',5,'Color','g');
        dispImag = insertShape(dispImag,'Line',Vline,...
            'LineWidth',3,'Color','g');
        dispImag = insertShape(dispImag,'Line',Hline,...
            'LineWidth',3,'Color','g');
        imshow(dispImag);
        mykey = get(gcf,'CurrentCharacter');
        if mykey == 's'
            where = [address num2str(i) '.png'];
            data_img = imcrop(img,rectange);
            imwrite(data_img,where);
            disp(['Saved at ' where]);
            i = i+1;
            set(gcf,'CurrentCharacter','@');    % set to a dummy character
        end
    end
end