% Program that detetcs a face within an image named 'filename'.
% Date : 23 - 05 - 20
% Adapted by: Nicolás Alejandro Ávila
% Description: This program was adapted from an existing one ('Original_Detect.m') on the
% internet. The original one just detects a face in a frame and draws
% an bounding box. This one extracts images from 'dirname' and saves the
% detected faces in 'Faces' directory.

function detect_face(dirname)

%Setting images to be analized.
folder = dirname;
Images = dir(fullfile(folder, '*.png'))

%Setting direction for image saving.
OutImgDir = 'Faces';
 mkdir(OutImgDir);

 %Loop for the images in 'dirname'.
 for i = 1:numel(Images)
     
% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector();

% Read an image and run the detector.
filename = fullfile(folder, Images(i).name);
img = imread(filename);
bbox = step(faceDetector, img);

%Crop the image.
data_img = imcrop(img,bbox);

%Setting names and saving
 basefilename = Images(i).name;
    fullfilename = fullfile(OutImgDir, basefilename)
    imwrite(data_img, fullfilename);

 end

end