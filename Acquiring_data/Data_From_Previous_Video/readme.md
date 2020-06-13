MATLAB codes **Data_From_Video.m**, **Detect_Face.m**, **Number_Of_Frames.m** and **Original_Detect.m** are include in this folder.

 **Data_From_Video.m** extracts frames from a selelected video and saves them in the folder **'Frames'**. As an example, I used an interview found on YouTube's url: https://www.youtube.com/watch?v=y214JRLbT4M, which I called **'Entrevista.mov'** and an spacing of 50 frames.

 **Detect_Face.m** detects faces from images in a folder and saves them into a new folder called **'Faces'**. As an example, I used images from 'Frames'. There is a problem with **imcrop** function in  **Detect_Face.m**: it does not work when more than one face is detected as shown in **'Error.png'**. That's why i had to cut a portion of the recorded screen: I included a picture of the original interview, called **'Original_Interview.png'**. The code for face detection was taken from the url: https://es.mathworks.com/help/vision/examples/face-detection-and-tracking-using-camshift.html and I have included the original code as **Original_Detect.m**. An example of the results of the original code is called **'Detection.png'**.

 **Number_Of_Frames.m** prints the number of frames of a given video file, 'video_name'. Its purpose is to give an idea of an ideal spacing to use in 
 **Data_From_Video.m**.

 Images obtained by this method can be used to synthesize filters for face recognition. It would be interesting to use this with videos of the group members. A second application of  **Detect_Face.m** on 'Faces' images seems to decrease the background effect on the face detection. However, some mistakes like double detection or nule detection appears. Acquiring data from live video seems to be a better solution.