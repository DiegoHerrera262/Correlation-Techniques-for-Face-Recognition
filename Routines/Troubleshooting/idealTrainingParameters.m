%% Program for Selecting Ideal MACE Filter Parameters
% Date: 02 - 06 - 20
% Author: Diego Herrera
% Description: In this program a single MACE filter is computed
%              for a sample image and PSE is computed for the
%              correlation output of the other images in the
%              set. A plot of PSE vs. Image number is generated

function [irefimag, indicator] = idealTrainingParameters...
   (subject,numsamp,filttype)
    %% Compute indicator of performance vector
    indicator = zeros([199 1]);
    % iterate over reference images
    for refimag = 1:199
        %% Compute CF with refimag as a template
        usedImages = {};
        if strcmp(filttype,'MINACE')
            usedImages = MINACE_Filter(subject,refimag,numsamp,199);
        elseif strcmp(filttype,'HBCOM')
            usedImages = HBCOM_Filter(subject,refimag,numsamp);
        elseif strcmp(filttype,'MACE')
            usedImages = MACE_Filter(subject,refimag,numsamp,199);
        end
        
        %% Compute PSR values for true & flase classes
        [true_psrvals, ~, idk] = PSR_Database...
            (subject,subject,filttype);
        false_psrvals = PSR_Impostors(subject,filttype);
        
        %% Compute usedImages index
        usedImagesIdx = zeros([numel(usedImages) 1]);
        for k = 1:numel(usedImages)
            % Extract real image index
            s1 = split(usedImages(k),'sample');
            s2 = split(char(s1(2)),'.');
            usedImagesIdx(k) = uint16(str2double(char(s2(1))));
        end
        
        %% Compute mean over subset of unused true images
        % This reduces the bias of the high used-images peak
        cond = ~ismember(idk,usedImagesIdx);
        true_mean = mean(true_psrvals(cond));
        true_std = std(true_psrvals(cond));
        
        %% Compute mean over impostor sets
        false_mean = mean(false_psrvals);
        false_std = std(false_psrvals);
        
        %% Compute indicator
        indicator(refimag) = (true_mean - true_std) - ...
            (false_mean + false_std);
    end
    %% Compute value of ideal reference image for numsamples
    [~, irefimag] = max(indicator);
end