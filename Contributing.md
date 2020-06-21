# Contributing Guidelines

Welcome to **Correlation-Techniques-for-Face-Recognition**! We appreciate your interesting in making this a larger project for exploring non-segmentation techniques in biometric recognition. Here are some do's and dont's for contributing.

## Routines and Structure of the project

This repo has a pretty well defined protocol for data acquisition, image preprocessing, filter construction and biometric verification using normalization metrics. Be sure that you understand the techniques and the associated workflow before contributing. You can read all about it in the [website of the project](https://diegoherrera262.github.io/Correlation-Techniques-for-Face-Recognition/). The protocol is intimately related to the folder structure of the repository. We propose guidelines for:

1. **Image generation and storage**
1. **Data acquisition algorithms**
1. **Preprocessing algorithms**
1. **Filter synthesis algorithms**
1. **Metric implementation**
1. **Applications involving actual biometric verification**

As a general rule, each type of contribution is associated with a corresponding folder in the git repo. Clearly, Images are stored in ```RawDatabase``` and ```ProcessedDatabase```, whereas algorithms are ***implemented in MATLAB language***, and stored in their task-related subfolder on ```Routines```. Keep in mind the function of your contribution before uploading it, so that you can properly identify its location folder. Do not contribute a particular code unless you are completely sure of its pertinence and its function in terms of the other committed routines.

## Image commits

```RawDatabase``` and ```ProcessedDatabase``` contain PNG files with raw sample images and preprocessed sample images as discussed in the README. Under no circumstances should you contribute any image if it is not generated via **acquire_data** or **filter_images**. Otherwise you can generate conflicts in the internal data management. Do not contribute images from results obtained after snapshot capture or preprocessing corresponding to a troubleshoot. Those are for your own analysis.

If you are a collaborator, create a markdown file with the path ```ProjLog/(First Name)WorkLog.md``` and feel free to document your exploration Preprocessing. Include your troubleshooting images on the subfolder ```Results```. Template for logging is [LuisWorkLog.md](ProjLog/LuisWorkLog.md). Feel free to include properly titled and described graphics.

## Code commits

All codes committed to the repo should be written in **MATLAB language** and properly commented and described. Use a descriptive title that summarizes the function of the code, and a header with the following structure:

```Matlab
%% Program for Assessing MACE Filter Performance in Trainning set
% Date: 02 - 06 - 20
% Author: Diego Herrera
% Description: In this program a single MACE filter is computed
%              for a sample image and PSE is computed for the
%              correlation output of the other images in the
%              set. A plot of PSE vs. Image number is generated
```

This header is required for all commits. Use ```%%``` string for separating internal subprocesses of the routine, like reading directories, computing a filter or generating a graphic. Use the structure

```Matlab
%% Descriptive summary of the task
% Particular important details of the process
func1
func2
func3
```

Never include comments in all caps, and always use English in your text. Follow strictly this guidelines for committing codes. In addition, you must make your routines as efficient as possible. Avoid code replication, search for optimized toolbox functions that simplify your code and apply the principles of procedural programming. Modularize your programs with wisdom. Try to commit MATLAB function files rather than scripts. Troubleshooting scripts should be stored on the ```Routines/TrialFuncs``` directory, and they are mere work-in-progress functions. Always commit MATLAB scripts, never live scripts. If one of those scripts is rendered outdated, it must be deleted as soon as possible.

### Data acquisition algorithms

This algorithms must follow the principle of minimal interface for the user. So, try to display a live interactive video for snapshot capture. Include a target to facilitate face location in the image plane, and include a well suited interest region. For file management, take as a template **acquire_data.m** for consistency. Commit your code on the folder ```Routines/Acquiring_data```. Before any commit, test your code locally and keep in mind that the ease of use is the primary goal. Remember that images must be saved in ```RawDatabase/Subject``` using a filename of the type ```sample*.png```. Be consistent with numeration of the samples.

### Pre-processing algorithms

Try to keep in mind a well-ordered sequence of preprocessing tasks to

* Reduce the noise in the raw image database.
* Highlight contrast and interest features.
* Reduce intensity sensitivity of the matching algorithms.

Be careful with file management. Take as a template **filter_images.m**. Remember that all preprocessing codes must read images from ```RawDatabase/Subject``` folder, and save processed images in ```ProcessedDatabase/Subject_filtered```.Remember that images must be saved in ```ProcessedDatabase/Subject``` using a filename of the type ```filtered_sample*.png```. Be consistent with numeration of the samples.

### Filter synthesis algorithms

Remember that the basic idea of this kind of functions is that they receive a **preprocessed image database**, a reference training image and a training subset size for filter computation and training. To avoid file management conflicts, use **MACE_Filter.m** as a template in the most literal way. Create a copy and edit the filter synthesis and training parts of the code. Try to be careful with memory management. Image matrices are huge and a careless management of memory can lead not only to underperforming, but also to bad execution errors.

### Metric implementations

These codes must always be functions. They should receive a correlation plane and output the respective metric as a double variable. In some cases, an additional output can be the location of the peak. Take **PSE.m** as a template.

### Applications involving actual biometric verification

These should ideally take the form of MATLAB apps with a user-friendly user interface. Try to store them in a subfolder ```Routines/Applications```. Focus on biometric verification rather than biometric identification since the former is the main goal of the project.

## Documentation & Interaction

If you are a contributor, please create your log with the format described above. Define your tasks as issues in the Github page. Encourage other members to give feedback as comments. The issues have a hierarchy depending on the level of generality. Those associated to a milestone are the most general ones and have child tasks that correspond to more concrete goals. Most general ones are tagged with label **Main**, and those with more immediate time goals are tagged with **help wanted**. You are free to define your working direction as long as it is clearly connected to the main tasks. Those tasks that correspond to **Documentation** are labeled appropriately.

The theoretical and experimental foundations of the routines implemented should be clearly stated and documented in the [Wiki page](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/wiki) of the project. The current tasks of the project must be registered in the board, and follow the obvious guidelines in [the page](https://github.com/DiegoHerrera262/Correlation-Techniques-for-Face-Recognition/projects/1).

## Final remarks

Always follow the code of conduct of the repo and remember that creativity only flourishes if you are structured enough to know where to innovate. Thanks for your support.
