%The original code, detects faces in a frame of the video 'visionface.avi'
%and then shows the image with a rectangle surronding the detected faces.
%A modification wich works with an image 'imagename.png' is commented at the end.

% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector();

% Read a video frame and run the detector.
videoFileReader = VideoReader('visionface.avi');
videoFrame      = readFrame(videoFileReader);
bbox            = step(faceDetector, videoFrame);

% Draw the returned bounding box around the detected face.
videoOut = insertObjectAnnotation(videoFrame,'rectangle',bbox,'Face');
figure, imshow(videoOut), title('Detected face');

---------------------------------------------------------------------------

%faceDetector = vision.CascadeObjectDetector();


%videoFrame      = imread('imagename.png');
%bbox            = step(faceDetector, videoFrame);


%videoOut = insertObjectAnnotation(videoFrame,'rectangle',bbox,'Face');
%figure, imshow(videoOut), title('Detected face');

--------------------------------------------------------------------------