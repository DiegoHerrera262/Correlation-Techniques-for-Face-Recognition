# Correlation Filters for Facial Recognition

In this Repo you will find MATLAB codes used to explore non-segmentation techniques for facial recognition using correlation techniques with linear filters. It is a project developed for the course on Optics and Acoustics from the National University of Colombia. It is carried out by:

* Diego Alejandro Herrera Rojas
* Luis Carlos Duran Neme
* Andrés Felipe Duque Bran
* Nicolás Alejandro Ávila Pérez

## Description

The main objective of the project is to design and implement a correlation-based static facial verification algorithm. That is, an algorithm that automates the recognition of a person using his or her face, with an accuracy higher than 80%. In order to achieve that goal, the following specific objectives were set:

* Determine an image database acquisition protocol that allows synthesis of a robust linear filter in terms of intensity and noise in the image.
* Develop an image acquisition routine that automates this part of the process.
* Implement a robust algorithm for filter design and synthesis, both for MACE and HBCOM filters.
* Implement normalization metrics that allow for correlation peak characterization and a confidence of 80% in facial verification.

## How to use the routines

For a detailed description of the theoretical and experimental reasons for the defined protocol of routines usage see the wiki page of the project. The protocol has the following steps:

* MATLAB environment setup.
* Image database acquisition.
* Image preprocessing.
* Filter synthesis.
* Performance simulation.

Those are discussed further in the following subsections.

## MATLAB environment setup

Clone this repository to a folder in your local memory drive. Download MATLAB development environment from the official website and add the following add-ons from the official website:

* **Image Acquisition Toolbox** from MathWorks
* **Image Processing Toolbox** from MathWorks
* **Matlab Support Package for USB webcams** from MathWorks

We suggest using MATLAB 2019b version or later. The toolboxes above are necessary for subsequent steps of the protocol. Make sure they are installed before carrying on. On the MATLAB development environment open the root folder of the cloned repository in your PC. The MATLAB current folder window should look something like bellow:

<p align="center">
  <img width="460" height="300" src="Results/README/demoEnvironment.png">
</p>

Make sure that your current folder window looks like that before going on. Then run the script **setup.m** in the command window as follows:

<p align="center">
  <img width="460" height="300" src="Results/README/demoSetup.gif">
</p>

This script should add the folder **Routines** to MATLABPATH and enable execution of the programs contained inside. Regular cleaning up of the workspace variables is advised in order to avoid conflicts. Also try to clean up the command window regularly. Use the commands:

```Matlab
clear varname;            % This deletes variable varname
clc;                      % This cleans command window like clear on command promt
```
Once your environment is set up you can:

* Generate an image database in your local hard drive.
* Compute a MACE, HBCOM or MINACE filter.
* Examine correlation outputs for a particular image in the database.
* Compute normalization metrics for peak quality assessment.
* Carry out performance simulations of one of those filters.

## Image database acquisition

This is the first step to carry out after repo cloning and environment setup. Database acquisition requires two steps:

1. Setting up of the illumination conditions and webcam for snapshot capture.
1. Calling function **acquire_data**.

### Setting up illumination conditions

This is a very important step. A proper illuminations reduces the noise in the captured snapshots. This is a feature quite desirable for improving the performance of the filters in facial recognition. Ideally, the set up should include 4 light sources with proper screening (i.e. a white paper sheet) coming from crossed directions, two lateral, one above and one bellow the face of the subject. If the last one is not feasible, then make sure the other three are available at all costs. A simple demo of the set up is shown in the image bellow.

<p align="center">
  <img width="460" height="300" src="Results/README/demoIllum.gif">
</p>

Once good illumination is ensured, run the routine **acquire_data**.

### Calling function acquire_data

This simple routine captures a definite number of snapshots and saves them in a folder with subjects name in **RawDatabase** folder. By default, images are stored in PNG format, since JPG loses too much information. This is automatically managed by the routine and user must not worry about that aspect. User must establish a webcam connection in MATLAB workspace. To do that, type ```webcamlist``` on command window. This will produce a cell object that contains the names of the possible USB webcams that MATLAB can access. Preferable connection is to built-in webcam. If none is available, it is suggested that user installs apps like **EpocCam** or **DroidCam** that allow management smartphones as USB webcams for several desktop applications. Keep in mind the index of the name of the desired connection. The type in the command window:

```Matlab
cam = webcam(idx)
```
Where ```idx``` stands for the index of the desired connection in the webcam list. If a connection to built-in camera is established, a green LED must turn on. If no semicolon is added, something like this should be prompted in the command window:

```Matlab
cam =

  webcam with properties:

                    Name: 'Cámara FaceTime HD (integrada)'
    AvailableResolutions: {'1280x720'}
              Resolution: '1280x720
```

Make sure that the resolution is 1280x720 for internal consistency. Change the resolution typing in the command window:

```Matlab
cam.Resolution = '1280x720'
```

**NOTE**: *If the available resolutions do not include this value, the programs can still be used but only with data taken with the same webcam*.

Once connection to webcam device is successfully stablished, execute:

```Matlab
acquire_data(num_samples,cam,subject_name)
```

* ```num_samples``` is the number of snapshots to be stored. It is suggested that exactly 200 samples be stored, however, user may decide. This does not have to do with filter performance, but ensures consistency when carrying out performance simulations.

* ```cam``` is a webcam connection in MATLAB workspace.

* ```subject_name``` is a string that contains the first name of the subject. If already a folder in **RawDatabase** has that name, include the first letter of the last name, and so on.

Execute steps as in the following animation:

<p align="center">
  <img width="460" height="300" src="Results/README/demoAcqdata.mp4">
</p>

A live video with a target will appear in the screen as shown:

<p align="center">
  <img width="460" height="300" src="Results/README/demoInter.png">
</p>

Please make sure that the images are properly centered by locating the nose on the center of the target. Also, make sure that the eyebrows and upper part of the chin are located at the upper limits of the box. Additionally, locate the lateral borders of the face in the corresponding sides of the box. It is advised that the image plane of the face remains constant while the facial expression is changed. However this is a user call. In order to save a snapshot, ***click the figure window and press s key***, always in that sequence. A message will appear on the command window ensuring that the snapshot was successfully saved.

If these steps are followed correctly, 200 PNG files with the names ```sample*.png``` must appear on the folder ```RawDatabase/Subject```. These images will be used for filter synthesis after preprocessing.

## Image Preprocessing

This step is fundamental for intensity adjustment and image de-noising. Preprocessed images are stored in the folder ```ProcessedDatabase/Subject_filtered```. The following preprocessing techniques are used:

1. Adaptative Histogram Equalization
1. De-nosing via Wiener filter.

These are implemented in the function ```filter_images```. The usage is quite elementary since internally all the hard processing and saving parts are carried out by the function. The user must enter in the command window:

```Matlab
filter_images(Subject)
```

Where ```Subject``` is a string with the name of the subject whose raw images are stored in the folder ```RawDatabase/Subject```. Once this is done, a new folder in the above mentioned location must appear with PNG files whose format name is ```filtered_sample*.png```. A sample of raw and preprocessed images is shown bellow:

<p align="center">
  <img width="460" height="300" src="Results/README/demoPrepro.png">
</p>

**NOTE**: *For more conceptual and procedural details of this part of the protocol visit the wiki of the project repository*.

## Contents

The project contains the following folders:

1) **MATLABCodes**: This folder contains the MATLAB codes used to explore the capabilities of correlation techniques.
2) **images**: Contains images for filter synthesis and further facial identification processes.
3) **Figures**: Contains images for initial exploration.

## Push Formats

In order to keep track of the work, the following formats are proposed for committing files to the repository:

* All code files must be in a directory with the name **(Language)Codes**. For instance, if the codes are in MATLAB, they must be in the directory **MATLABCodes**.

* All code files must have a heading that includes: 1) Descriptive title, 2) Author's name, 3) Date of deploy, 4) Brief description. Codes must be accurately commented so that anyone can understand them.

* Al images that are not used for filter synthesis must go in the directory **Figures**. Images that are used for filter synthesis must be in directory **images**, and in a subdirectory with the name of the person to be identified.

* Al images must be stored in *PNG* format.
