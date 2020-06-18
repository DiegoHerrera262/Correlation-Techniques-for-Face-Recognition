%% Program that takes pictures and saves them in current directory
% Date : 13 - 06 - 20
% Author: Nicolás Alejandro Ávila
% Description: This program include code from Draw_Rectangle to visualize 
% a box in a live preview, takes a snapshot and crops the image inside
%the rectangle. The rectange format is the usual
%[xsupleft,ysupleft,width,height] and cam must be the camera name 'Name'.
%              Suggested values width = 200, height = 200
%                               xsupleft = 220, ysupleft = 80

function live_data(cam, num_samples,rectange,dirname)

mkdir(dirname);
     
%Draw_Rectangle Code
vid = videoinput('winvideo');
set(vid,'ReturnedColorSpace', 'RGB');
vidInfo = imaqhwinfo(vid);
vidRes = vid.VideoResolution;
imWidth = vidRes(1);
imHeight = vidRes(2);
numBands = vid.NumberOfBands;
hFig = figure;
hAxes = axes(hFig);

i = 1;
while i < num_samples

%More Draw_Rectangle Code
hImage = image(hAxes, zeros(imHeight, imWidth, numBands, vidInfo.NativeDataType));
preview(vid, hImage);
hLine = rectangle('Position', rectange, 'EdgeColor','r','LineWidth',2 );

%Setting names
basefilename = sprintf('%d.png', i);
fullfilename = fullfile(dirname, basefilename)

%Taking snapshots
         y = input('Ready to take sample? (1/0): ');
        if y == 1
            stoppreview(vid);
            CurrentImage = getsnapshot(vid);
            insertShape(CurrentImage,'Rectangle',rectange,'LineWidth',5);
            data_img = imcrop(CurrentImage,rectange);
            imwrite(data_img, fullfilename);
            i = i+1;
        end
       
    end
end