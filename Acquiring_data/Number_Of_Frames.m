%Program that prints de number of frames of a given video file.
%Author: Nicolás Alejandro Ávila
%Description: This program takes the video file name 'video_name' 
%and prints the number of frames.

function number_of_frames(video_name)

%Creates and object with de video.
vidObj = VideoReader(video_name);

%Number of frames in the video.
vidfram = vidObj.NumberOfFrames;

%Print value
disp(vidfram);

end