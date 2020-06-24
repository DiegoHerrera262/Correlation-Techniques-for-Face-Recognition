# Work Log - Nicolás A.

Brief descriptions of the code developed by me are included at the end.

**Date:** 22/05/2020

## First steps in Data Acquisition Automation

As a first idea within Data Acquisition Automation, my work consisted in focus on a video of a person face, previously taked, and try to extract a specific number of frames. This took me to read further about the VideoReader object implemented in MATLAB.

Through this, I was first able to create a function that prints the number of frames of the considered video, namely, the Routines/Acquiring_data/Data_From_Previous_Video/Number_Of_Frames.m function. Then the next step was to develop the code to extract an specific frame of the video, which is implemented in Line 24 of Routines/Acquiring_data/Data_From_Previous_Video/Data_From_Video.m funtion. 

Finally, merging the obtained results, a code which takes the video, extracts frames with a desired spacing and saves them in a specific folder was written. Namely, the Routines/Acquiring_data/Data_From_Previous_Video/Data_From_Video.m funtion. 

**Date:** 23/05/2020

## Detecting faces

Code for detecting faces on the previously extracted frames was needed. Fortunately, there is a face detector implemented in MATLAB which I was able to use. Further, I found a code on the web which serves for the stated purposes. The page can be consulted through the url https://es.mathworks.com/help/vision/examples/face-detection-and-tracking-using-camshift.html and the code is attached as Routines/Acquiring_data/Data_From_Previous_Video/Original_Detect.m. This code is able to detect a face within a given image, draw a box to enclose it, and show the modified image. 

The code was modified so that it was able not only to show the modified image, but also to cut the enclosed face and save it in a desired folder. Also a loop to read all the images from a specific folder and apply detection-cutting-saving process was implemented, resulting in  Routines/Acquiring_data/Data_From_Previous_Video/Data_From_Video.m function.

Images obtained by this method can be used to synthesize filters for face recognition. However, problems like double face detection or an important background pressence appeared on the processed images. 

**Date:** 27/05/2020

## First problems

I focused on solving problems with double face detection and backgroung pressence derived from Routines/Acquiring_data/Data_From_Previous_Video/Data_From_Video.m function. I found no suitable solutions for backgroung pressence effect, and for double face detection it seems that discard the bad images was the only way.

---------------------------------------------------------------------------

Descriptions of MATLAB codes **Data_From_Video.m**, **Detect_Face.m**, **Number_Of_Frames.m** and **Original_Detect.m** are included.

 **Data_From_Video.m** extracts frames from a selelected video and saves them in the folder **'Frames'**. As an example, I used an interview found on YouTube's url: https://www.youtube.com/watch?v=y214JRLbT4M, which I called **'Entrevista.mov'** and an spacing of 50 frames.

 **Detect_Face.m** detects faces from images in a folder and saves them into a new folder called **'Faces'**. As an example, I used images from 'Frames'. There is a problem with **imcrop** function in  **Detect_Face.m**: it does not work when more than one face is detected as shown in **'Error.png'**. That's why i had to cut a portion of the recorded screen: I included a picture of the original interview, called **'Original_Interview.png'**. The code for face detection was taken from the url: https://es.mathworks.com/help/vision/examples/face-detection-and-tracking-using-camshift.html and I have included the original code as **Original_Detect.m**. An example of the results of the original code is called **'Detection.png'**.

 **Number_Of_Frames.m** prints the number of frames of a given video file, 'video_name'. Its purpose is to give an idea of an ideal spacing to use in
 **Data_From_Video.m**.

 **Draw_Rectangle.m** Shows a rectangle on the webcam's live video using the usual parameters [xsupleft,ysupleft,width,height]. First step to take data from live videos.

 **Live_Data.m** Allows to take photos using live video preview.

 Recommentadion: Use Draw_Rectangle.m first, in order to determine the best values for rectange parameters.
