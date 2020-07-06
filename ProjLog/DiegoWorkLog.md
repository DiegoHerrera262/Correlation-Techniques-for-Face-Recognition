# Work Log of Project

This log is written by Diego Herrera, *insert other names*. It resumes the learning experience in the development of the project.

**Date:** 16/05/2020

##  Exploring correlation techniques in Biometric recognition

Diego Herrera read chapter 15 of Trussell's book on Image, Video and Biomedical Signal Processing from Academic Press Library (Vol. 4) and found out that biometric recognition can be performed using correlation filters. The principle is quite straightforward, and he includes an scheme of the algorithm in the book.

![](ProjLog/Results/README/demoAlgorithm.png)

The fundamental idea is the following:
1. A set of training images with the desired feature is generated, and all are preprocessed.
1. Those training images are used to create a **correlation filter** according to carefully chosen criteria.
1. The correlation of a test image with the filter is computed (in image frequency space).

> If the correlation output produces a sharp peak, then it is very likely that the test image contains the feature of interest. This peak indicates the location of the feature in the test image plane. If there is no match, then there must be no peak at all.

Hence, he came up with the following objective for the project:

> Design and implement a correlation-based static facial verification algorithm. That is, an algorithm that automates the recognition of a person using his or her face, with an accuracy higher than 80%

At first glance, he realized that a good correlation-based biometric verification system must include:

* A set of **preprocessed training images** that characterize a feature of interest.
* An **algorithm for filter design** based on clear physical criteria.
* A **training algorithm** for the filter. The so called training image registration.
* A metric for match identification. The so called **output normalization**.

Looking at the whole algorithm, some additional ingredients are implied:

* The definition of a **proper image acquisition environment** so as to narrow down the optimal operation conditions of the identification algorithm.
* A proper **image acquisition algorithm**, for both test images and training images.

**Note:** One must distinguish between *verification* and *identification* in recognition applications. The former means theresholding in order to check for the presence of a target feature. The last one means selecting the best correlation output from a set of possible matches. The project focuses on *verification*. If time is enough to implement a more complete application, then it might include identification.

**Date:** 16/05/20

## Data acquisition in MATLAB

Due to quarantine, Diego is limited to using his pc's webcam. Fortunately, MATLAB has access to webcam using *Image Acquisition Toolbox*. The function for activating the webcam is ```webcam()```. It creates an object that controls an specified webcam. [The following link refers to documentation](https://la.mathworks.com/help/supportpkg/usbwebcams/ug/acquire-images-from-webcams.html). At this stage he was not concerned with the particular acquisition environment, but with an automation of the process.

In the file **acquire_data.m**, he wrote a function that takes a step in that direction. That function takes a snapshot and crops a particular sub-image that should contain the biometric target (i.e. face). The function requires user validation for data storage. The problem up to now is that even though the function displays the snapshot it does not do that in a common fashion, that is, as a video. It only shows the snapshot and the cropped area. This feature must be improved.

**Note:** The instructor suggested that he selected snapshots from a previously taken video, however, this is not quite good since the sudden motion of the person may cause unwanted distortion from frame to frame, and careful selection of training images requires direct assessment of the programmer anyway.

**Date:** 18/05/2020

### Advanced Correlation filters

The main point here is that training images are used to build a correlation template. Diego read the chapter and concluded that a suitable correlation filter for biometric verification is the **MACE filter**. This filter is computed using the formula:

$$h = D^{-1}X(X^HD^{-1}X)^{-1} u\\ D := \text{Average power spectrum} \\ X := \text{Image matrix}$$

This equation is in image frequency domain. The main feature of the MACE filter is that it minimizes the *average correlation energy* in the correlation output for images in the training set. In addition, this filter fixes the response of this image set.

> According to the book, MACE Filter should produce very sharp peaks for images quite similar to the training set, and no peak at all for impostor images.

**Note**: The use of the spectral density amounts to whitening the average spectrum of the training images.

A bit more on the computation of this filter. The formula above requires several steps:

1. **Computation of the $X$ matrix**: Suppose one has access to a database of $N$ images of size $M = s \times r$. Then $X$ is $M \times N$ matrix whose columns are the vectors that contain the images.

1. **Computation of the $D$ matrix**: It is a diagonal matrix that contains the average power density of the training images:

$$D = diag\bigg(\frac{1}{N}\sum_{i} \bold{x}_{i}^H \bold{x}_i\bigg)$$

3. **Selection of the constrained response**: A MACE filter is constrained, that means that the response of an image is fixed. Commonly, this is expressed in the equation:

$$ u^H = h^H X^H$$

So, the basic implementation of the MACE filter is in the **MACE_Filter.m** function file. The function reads images from a directory, computes its DFT and generates the $X$ matrix putting the images as column vectors in the array. At the same time, it computes the average power density of the images.

```Matlab
%% Generating matrixes for filter computation
for i = 3:numel(images)
    % Read image from directory
    filename = [basedir '/' dirname '/' images(i).name];
    im = fftshift(fft2(rgb2gray(imread(filename)),m,n));
    % Update matrix of images
    X(:,i-2) = im(:);
    % Update Power Spectra Matrix
    P = P + im(:) .* conj(im(:)) * 1.0/(numel(images)-2);
end
```

After that, the function computes the product $D^{-1}X$, and the filter using the proposed formula. This is the piece of code that does that:

```Matlab
%% Computation of filter
dims = size(X);
iP = 1 ./ P;
% Compute DX & iDX matrix
for i = 1:dims(2)
    iDX(:,i) = iP .* X(:,i);
end
XDX = (conj(X') * iDX);
filter = (iDX / XDX) * u;
filter = reshape(filter,orsize(1),orsize(2));
```

It is important to note that images occupy quite a lot of memory. So the product $D^{-1}X$ is computed using:

$$(D^{-1}X)_{ij} = D_{i}X_{ij}$$

The matrix products are efficiently computed using MATLAB, they take around 0.5 seconds. However, this filter is not suitable for biometric verification in live video. After that, the function saves the filter for further use. A set of 500 images was taken using the image acquisition routine, and a MACE filter was computed. A test of the performance was carried out in the file **troubleshoot.m**. The results are shown bellow.

The results show that the better the match, in principle, the higher the peak in the correlation output. Also, the peak is far less spread with the MACE filter than with the sole correlation.

Some remarks must be made to this function:

1. The intensity of the peak is quite small, so the normalization using a metric is paramount for interpretation of the results.

1. The filter is not trained. There is **not image registration**.

1. The images are not properly preprocessed. The filter is quite sensitive to intensity variations.

1. The environment for image acquisition (i.e. illumination, location) may not be suitable for the application and needs modification.

**Date:** 19/05/20

## Documentation of the Project

To this date, Diego has ben a bit careless and sparse with his work. He was not quite aware of the importance of preprocessing training images, and did not care about a training algorithm for improving performance. He was aware of output normalization, and was expecting to apply a particular metric to the correlation output. He set up a meeting with one of his coworkers and they resolved to organize the project board on the Github repo. It must contain the general tasks defined on 16/05/20. Also, all weekly tasks must be added with the label *help needed* as an issue. The idea is that the work be more collaborative and to enhance group interaction. Also, all members of the group will have an individual log to document their work, and the general documentation of the project is to be registered in the wiki page.

**Date:** 22/05/20

## Normalization as Preprocessing Technique

Diego decided to create a function for automate MACE crosscorrelation computation. The main objective is to create more compact code. This function is in the file **MACExcorr.m**. The function uses DFT for computations:

```Matlab
function corplane = MACExcorr(test_im,filtername)
    %% Read MACE Filter from directory
    Filter = load(['filters/' filtername '.mat']);
    Filter = Filter.filter;

    %% Compute Correlation
    fft_test_im = fft2(test_im);
    fft_cor = sqrt(fft_test_im .* conj(Filter));
    corplane = abs(fftshift(ifft2(fft_cor)));
end
```

It is important to update documentation of the codes and the particular conventions for the correct usage of the functions. Also, I noted that the cropping of the training image can be done more focused on the face, inn order to avoid influence of the background. I then included the normalization in the computation of the filter:

```Matlab
%% Generating matrixes for filter computation
for i = 3:numel(images)
    % Read image from directory
    filename = [basedir '/' dirname '/' images(i).name];
    im = normalize(double(rgb2gray(imread(filename))));
    im = fftshift(fft2(im,m,n));
    % Update matrix of images
    X(:,i-2) = im(:);
    % Update Power Spectra Matrix
    P = P + im(:) .* conj(im(:)) * 1.0/(numel(images)-2);
end
```

It obviously produced mistakes because ```normalize()``` acts on matrix columns. Hence, one must first convert it to vector, normalize, and then return to matrix form. After correcting that, turns out that the filter s still unable to correctly match Diego's face. Some possible problems are:

* The data base is not correct, the face must be fitted in a better manner, avoiding background content.

* Intensity conditions must be carefully chosen while acquiring training data. The filter is quite sensitive to intensity variations.

* The computation of correlation must be revised. Perhaps the algorithm is not correct. Need to check correlation computation using DFT.
