# Code description

The following is the list of the programs written in the development of the project and a brief description of what they do.

## Programs related to MACE filter

**Troubleshott.m**: A demo file for testing different approaches and trying several ideas.

**show_filter.m**: It shows a computed filter as an image in order to visualize it.

**acquire_data.m**: It captures test images asking user input and displaying a cropping rectangle in a sort of video display.

**MACE_Filter.m**: Computes a MACE filter based on a database of snapshots.

**MATLABCodes/zeropadd.m**: Zero-padding of an image for fft computation. It is obsolete since fft2 function from MATLAB already carries that out.

**MATLABCodes/ECPSDF.m**: Computes ECPSDF filter for correlation computation. Obsolete since MACE is more effective.

**MATLABCodes/MACExcorr.M**: Computes xcorrelation of test image with MACE filter.

**Data_from_video.m**: Extrae imágenes de un video en función del espaciamiento entre ellas.

**detect_face**: Detecta y recorta rostros dentro de las imágenes.

**Preprocessing/enhance_images.m**: Adjusts the image contrast and intensity.

**Preprocessing/filter_images.m**: Filters the images using a Wiener filter by softing neighbour pixels.

**Preprocessing/correct_images.m**: Removes bakground enhancing image boundaries.
