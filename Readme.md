# Correlation Filters for Pattern Recognition

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

### MATLAB environment setup

Clone this repository to a folder in your local memory drive. Download MATLAB development environment from the official website and add the following add-ons from the official website:

* Image Acquisition Toolbox from MathWorks
* Image Processing Toolbox from MathWorks
* Matlab Support Package for USB webcams from MathWorks

We suggest using MATLAB 2019b version or later. The toolboxes above are necessary for subsequent steps of the protocol. Make sure they are installed before carrying on. On the MATLAB development environment open the root folder of the cloned repository in your PC. The MATLAB current folder window should look something like bellow:

<p align="center">
  <img width="460" height="300" src="Results/README/demoEnvironment.png">
</p>

Make sure that your current folder window looks like that before going on. Then run the script **setup.m** in the command window as follows:

<p align="center">
  <img width="460" height="300" src="Results/README/demoSetup.gif">
</p>


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
