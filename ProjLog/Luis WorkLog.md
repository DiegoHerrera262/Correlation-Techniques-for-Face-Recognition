# Work Log- Luis D.
***
## MAY 21st 2020.
Today the work was mainly focused on finishing the update of github's wiki page in terms of the VLC correlator and face recognition codes developed to date and their respective implementations. The update contains the most important results obtained at the moment alongside the issues presented and the discussions and ideas that have come up to solve them.
Additionally, the already constructed function aquire_data.m was implemented to get the Reference pictures in an easier manner, since up until now i've been taking, chopping and storing the photos one by one, which is a very unproductive to do so.    
***
## MAY 22nd 2020
Today my attempt was to check how to use the normalize function as an image preprocessing technique to solve problems with brightness and intensituy on the picture. At first i noticed that applying the function directly after reading the image gives an error which also appears when trying to implement the normalization to a gray scaled picture. The error is:

Error using normalize>checkSupportedArray (line 176)
Invalid data type. First argument must be of type double, single, table, or timetable.

Error in normalize (line 87)
    checkSupportedArray(A,method,methodType,false);

Now, it appears to be that using the function im2double or mat2gray before normalization solves the issue. However, the question about if the normalization should be before or after normalizing arises. For this, i tried three  methods:

- In the first one we normalized before gray scaling which for a random image gives a standard deviation of 0.9988 and after gray scaling the std gives 0.2677
- For the second we normalized after gray scaling which for a random image gives a standard deviation of 0.9988. Keep in mind that the calculations are made with gray scaled images.
- Finally in the third one, we apply the im2double function imidietly after reading, but the normalization is done after gray scaling, which gives again a std of 0.9988.

Next, we executed these three methods in our correlation code for a VLC face recognition simulation. Where the reference set was formed with 20 images.
Compared to the original results (with no normalization) the correlation plane appears with more noise in all cases, but also the peak does not look reliable in the mthods 2 and 3. The peak for the first method is shorter compared to the original result, whiich could be due to the normalization, however its sharpnes and brightness, is not good. 

 Target and Reference | Original Correlation result  
:-------------------------:|:-------------------------:
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/NoNormInput.png)  |  ![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/NoNorm.png) 


 Target and Reference | Normalized Correlation result- Method 1  
:-------------------------:|:-------------------------:
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/Input3.png)  |![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/Norm.png) 
Normalized Correlation result- Method 2 | Normalized Correlation result- Method 3  
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/Norm2.png)  |  ![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/Norm3.png) 


However, is worth mentioning that these bad results were obtain for images with a very darker ilumination in comparison to most of the reference set. That being said, those pictures whose brightness is similar to the majority of the reference set give better results, specially when the subject is not wearing glasses.

 Target and Reference | Normalized Correlation result- Method 1  
:-------------------------:|:-------------------------:
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/InputB.png)  |![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/NormB.png) 
Normalized Correlation result- Method 2 | Normalized Correlation result- Method 3  
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/Norm2B.png)  |  ![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/Norm3B.png) 

For these new cases, one can see that for all cases the noise is lower and the peaks are better formed and higher than before. Particulary, methods 2 and 3 (which have in common that normalization is made after gray scaling) are the highest ones. Therefore, a first conclusion would be (again) that is extremly important to define a protocol to take the pictures, and also to have a proper ilumination.
***
## MAY 23rd 2020
Today, i design the proper rectangle of image acquisition for my own scene and camera characteristics, hence now the process of taking and storing the photos can be done faster, then a new sample of 50 images was taken using a light blue bed sheet as a background screen. Futhermore, i was finally able to improve the main structure of the codes for the VLC face recognition program, this was done by enhacing its capacity to perform operations thanks to the usage of the function "cell" and the command "for" which allowed me to do operations like image reading, gray scaling, matrix multiplications and sums in a more compact manner, avoiding tedious manual typing  and thus amplifying the code's capacity.   

Now, the three normalization methods disscused yesterday were applyied to this new code structure, and even though the mixed results remain exactly the same (since i didn't change the ref set here), the compilation and typing process clearly was much faster. Codes are named VLCNormBetter, VLCNorm2Better, VLCNorm3Better.
 
Finally i wrote a code (VLCfaceBetter2) for face recognition using the new structure and the 50 samples se, which also includes all 3 normalization methods, which can be exchanged by commenting (with %) certain parts properly, this also works if one wants to run the code without normalizing. The results for the normalization remain pretty variable depending on the input target image, however the peaks are in most cases narrower and higher than before (at least in methods 2 and 3). My guess is that ilumination problems remain, therefore the next step would be to change the light source.
***
## MAY 24th/2020
Today, my work was focused on trying to solve the issues i've been having with normalization, for this i tried with different approaches, all which had in common the usage of a new function that asigns by default new intensity values to a gray scale image ("imadjust").
- On my first attempt i applied the imadjust function after im2double and before normalization, resulting in most cases in the same surfaces i had obtain yesterday.
- My second option was to adjust the intensities after both doubuling and normalizing the image, obtaining a little shorter peaks and more noticible noise in the plane.
- As a third choice i implemented before imdouble and normalizing, which resulted again in the same results for correlation as yesterday.

Giving this results, i repeated them in an identical manner but performing the normalization in another way, by using mat2gray(image./sqrt(sum(image(:).^2))), which gave worse results than before, obtaining an even shorter and disorted peak, less sharp than before and also (in some cases) other bright spots mixed with more noise.

A conlusion to all this would be that either one has to asign manually the new intensity values or to focus more on the improvment of the image taking process.
I tried to add the new intensity values by myself using  imadjust(I,[low_in high_in]), which allowed me to put values between 0 and 1. I implemented this new form for intensity adjustment for all options i propose today, resulting in a new option, the best at the moment, described as follows:

Use im2doulble and normalization function imediatly after gray scaling, then use the adjustment function with values [0.07 0.2] and finally perform a new normalization. This method gave for most cases a shorter peak, however the noise was lower as well.
Bellow there're two examples: one where this method gave really good results and other where the results were no so good but defenetly better compared to its previous version in terms of noise and peak sharpness (even though it might be shorter). 
   
Gray sacale picture | Normalized Image  
:-------------------------:|:-------------------------:
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/gray1.png)  |![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/normalized1.png) 
Intensity adjustment | Renormalized Image  
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/adjust1.png)  |  ![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/renormalized1.png)

![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/NewNormBad.png)

Gray sacale picture | Normalized Image  
:-------------------------:|:-------------------------:
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/gray2.png)  |![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/normalized2.png) 
Intensity adjustment | Renormalized Image  
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/adjust2.png)  |  ![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/renormalized2.png)

![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/NewNormGood.png)

Finally, i noticed that most of the pictures that give better results are those in which my hair covers my forehead. These type of images represent the mayority of the reference set, which could be something to take into account. Futhermore, when the test image is not one of the references, results are bad still. The last code structure used today was uploaded by the name "VLCfaceBetter3"

***
## MAY 27th 2020
Today a new trial was made, following the last method used, i tried using the negative of the image to calcultate the correlation. To obtain the negative image, the function 	"imcomplement" was used, and for the code it was applyied after renormalization which in general gives a brighter peak, but with a little increase in noise and for those cases where the results have been good, it also gives a higher peak. For the target images that have been giving bad results, the peak seems to be higher but it's not very noticible and the noise remains parcticly the same, in some cases even a little noisier. At the end, a suggestion to use the edge function was made. The function helps to detect edges on an image by returning a binarize image highlighting the detected borders, it also can be implemented with various  recognition methods. 

***
## MAY 29th 2020
Today i implemented the edge function (inmediatly afrter using "imcomplement") which in general gives really good results, decreasing the noise in most cases and giving bright peaks. For the implementation, three edge detection methods were performed  'canny', 'sobel' and 'log', where the latter proves to have a better performance in comparison. Therefore, as an example of an imput image with bad results and another with a good correlation plane we use the same ones as before.

Input | Canny edge detection  
:-------------------------:|:-------------------------:
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/Input_edges_bad.png) |![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/cannyEdge_bad.png) 
Sobel edge detection | Log edge detection  
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/sobelEdge_bad.png)|  ![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/logEdge_bad.png)

Input | Canny edge detection  
:-------------------------:|:-------------------------:
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/Input_edges_good.png) |![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/cannyEdge_good.png) 
Sobel edge detection | Log edge detection  
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/sobelEdge_good.png)|  ![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/logEdge_good.png)

As mentioned above, the log method for edge detection gives really good results even for an image that used to cause problems in previous attempts. However, even though the noise is way much lower than before, the ideal result is to make it zero. The next suggested step is to implement a high pass filter as an image processing tool to highlight the edges in a better way. The code used today was uploaded by the name "VLCfaceBetter4"

***
## MAY 30th 2020
Today i added a new function to the structure i had before, called "bwlabel" which works for a binary picture (hence it must be implemented after applying the log method edge detection) and gives a label matrix that contains labels for connected elements on the picture. In comparison, the subject image doesn't look too altered, but the correlation plane on the other hand certainly has a significant change. 
In the correlation plane, the general results show a much higher peak in comparison to previous results, futhermore the noise on the plane is significantly attenuated and lower than the peak, which is definetly a good sign for the general performance. These results can be seen bellow. As always we show the examples for the same images (the "bad" and the "good" one):


Input | Log edge detection | Log edge detection + label function 
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/Input_edges_bad.png) |![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/logEdge_bad.png)| ![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/logEdge_and_label_bad.png)

Input | Log edge detection | Log edge detection + label function 
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/Input_edges_good.png) |![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/logEdge_good.png)| ![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/logEdge_and_label_good.png)

As a final comment for this section, is fair to say this new function was added to the previous code so it was reuploaded with the same name "VLCfaceBetter4" to avoid an accummulation of many codes.

For the second part of today's work, i took the firsts steps for future filter training 
by adding a  new part to the code in order to calculate the test image self correlation, in order to observe how well is the performance of the filter. Hence, the self-correlation results for the two example images are shown bellow:


Image | Self-Correlation
:-------------------------:|:-------------------------:
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/Edge_and_label_ImageBad.png) |![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/SelfCorr_bad.png)

Image | Self-Correlation
:-------------------------:|:-------------------------:
![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/Edge_and_label_ImageGood.png) |![](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/blob/master/Results/WorkLogResults-Luis/SelfCorr_good.png)


Based on these figures, one can see that the filter that's being implemented (plus the preprossecing done with normalizaton, edges and intensity adjustment) has a really good and reliable performance. This means, that noise problems are mostly due to a lack of filter traning or more image pre-processing methods. This code was uploaded by the name  "VLCfaceBetter_and_SelfCorr"

##  June 2nd 2020
Today i made four new references sets, one with 95 sample and daylight as a source, the second one was made with 95 images and using 3pm sunlight as the source, the third set was made out of these last two, and finally the last set was constructed with 199 new photos and a normal bedroom light bulb as the source. The sets were named Sample3A, Sample3B, Sample3, Sample4 respectevly and the results obtained were very similar as before.


