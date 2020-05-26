% Program that extracts pictures from a video.
% Date : 23 - 05 - 20
% Author: Nicolás Alejandro Ávila
% Description: This program extracts frames from a video with an specific
% spacing as a firt attempt for Data Acquisition Automation. That is, it
% takes a video names 'video_name' and saves every 'spacing' frames. For
% example, if spacing = 5, it will save frames number 1, 5, 10, 15, etc.

function acquire_from_video(spacing, video_name)

%Creates and object with de video.
vidObj = VideoReader(video_name);
%Number of frames in the video.
vidfram = vidObj.NumberOfFrames;

%Setting direction for image saving.
OutImgDir = 'Frames';
 mkdir(OutImgDir);

i = 1;
while i <= vidfram
    
    %Read the first frame to be taken.
    CurrentImage = read(vidObj, i);
    
    %Just setting the name and saving.
    basefilename = sprintf('%d.png', i);
    fullfilename = fullfile(OutImgDir, basefilename)
    imwrite(CurrentImage, fullfilename);
    i = i + spacing;
    
end

end