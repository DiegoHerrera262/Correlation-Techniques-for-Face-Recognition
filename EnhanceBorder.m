%% Program that applies high pass filter to image
% Date: 24 - 05 - 20
% Author: Diego Alejando Herrera
% Description: This code applies a high pass filter to a
%              generig rgb image, with a particular
%              raduis. Also includes zeroing the freqs.
%              along the axes of the freq. domain.

function enhanced = EnhanceBorder(im,radfilter)
    %% Parameters fol computation of HP filter
    % Convert to gray scale
    enhanced = rgb2gray(im);
    % Extract dimension of image for High Pass
    sizeim = size(enhanced);
    
    %% Computation of HP filter
    partition = 500;
    hpfilter = ones(sizeim);
    xcenter = int16(sizeim(1)/2);
    ycenter = int16(sizeim(2)/2);
    % Construction of the step filter
    for i = 0:partition
        for j = 0:partition
            t = radfilter*((1.0*j)/partition)...
                *cos(2*pi/partition*i)+xcenter;
            r = radfilter*((1.0*j)/partition)...
                *sin(2*pi/partition*i)+ycenter;
            hpfilter(int16(t),int16(r)) = 0;
        end
    end
    % Zero-padding axism components
    hpfilter(1:sizeim(1),ycenter) = zeros([sizeim(1), 1]);
    hpfilter(xcenter,1:sizeim(2)) = zeros([1, sizeim(2)]);
    %% Compute enhanced image
    % Compute fft of enhanced image
    fft_enhanced = hpfilter .* fftshift(fft2(enhanced));
    % Compute enhanced image
    enhanced = abs(ifft2(fft_enhanced));
    % Normalize for display
    enhanced = (enhanced - min(min(enhanced(:))))/...
        (max(max(enhanced(:)))-min(min(enhanced(:))));
    enhanced = uint8(255*enhanced);
    
end