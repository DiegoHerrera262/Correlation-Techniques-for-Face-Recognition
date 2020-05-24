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
Today, i design the proper rectangle of image acquisition for my own scene and camera characteristics, hence know the process of taking and storing the photos can be done faster, then a new sample of 50 images was taken using a light blue bed sheet as a background screen. Futhermore, i was finally able to improve the main structure of the codes for the VLC face recognition program, this was done by enhacing its capacity to perform operations thanks to the usage of the function "cell" and the command "for" which allowed me to do operations like image reading, gray scaling, matrix multiplications and sums in a more compact manner, avoiding tedious manual typing  and thus amplifying the code's capacity.
Now, the three normalization methods disscused yesterday were applyied to this new code structure, and even though the mixed results remain the same (since i haven't change the ref set yet), the compilation and typing process clearly was much faster.


