%% Program that takes pictures and saves them in current directory
% Date : 02 - 05 - 20
% Author: Diego Alejandro Herrera
% Description: This program takes sample pictures and computes a MACE
%              filter using matrix multiplication as in references.
%              dirname is the name of the directory where data is stored.
%              Alignment of images is not implemented yet.

function usedImages = MACE_Filter(dirname,refimag,num_imag,subspace_size)
    %% Establish location of images
    % In this applications, the trainig samples always contain the
    % substring sample as part of their name.
    
    curr_loc = pwd();                % Current MATLABPATH
    dataFolder = ['/' dirname];      % Name of data folder
    MatchName = '/*sample*.png';     % Sample name of image files
    
    %% Definition of data location
    % This creates a string that contains the system path of location
    
    folderLocation = [curr_loc dataFolder MatchName];
    
    %% Create Directory Object
    
    Data = dir(folderLocation);
    base = Data.folder;
    
    %% Read Reference Image
    % The system path of the image is generated using directory object
    
    RefImagLoc = dir([dirname '/*sample' num2str(refimag) ...
        '.png']);
    fullname = [curr_loc dataFolder '/' RefImagLoc.name];
    sample = imread(fullname);
    
    %% Define variables for filter computation
    % This part implements the MACE filter computation, If another type of
    % filter is desired, this function will work by changing this part of
    % the code for an appropriate formula for the filter.
    
    orgsize = size(sample);          % Original size of sample
    fftsamp = fft2(sample);          % Compute fft of sample
    % Compute filter
    x = fftsamp(:);                  % Matrix of images
    D = conj(x) .* x;                % Mean Power Spectrum
    iDx = x .* (1.0 ./ D);           % D^{-1}x
    filter = iDx / (conj(x') * iDx);   % MACE Filter formula
    % Resize for correlation computation
    filter = reshape(filter,orgsize(1),orgsize(2));
    
    %% Start Training
    % Only when trainig set has more than one image. Remember this same
    % function can be modified to compute another type of filter. Just
    % change the code after the second inner for to program the furmula
    % of the desired type of filter
    
    disp('Computing MACE...');
    usedImages = {fullname};         % Cell of used images
    disp(['Used image: ' RefImagLoc.name]);
    
    if num_imag > 1
        peakloc = zeros(subspace_size,2);
        psevals = zeros(subspace_size,1);
        for i = 1:(num_imag-1)
            % Compute PSE for images in Subspace
            for j = 1:subspace_size
                % read image from training set
                filename = [base '/' Data(j).name];
                im = imread(filename);
                corrplane = abs(fftshift(ifft2(...
                    conj(filter) .* fft2(im)...
                    )));
                % Compute PSE and Peak Location
                [pse, location] = PSE(corrplane);
                psevals(j) = pse;
                peakloc(j,1) = location(1);
                peakloc(j,2) = location(2);
            end
            % Locate worst performing image
            filename = [base '/' Data(psevals == min(psevals)).name];
            usedImages{end+1} = filename;
            disp(['Used image: ' Data(psevals == min(psevals)).name]);
            sample = imread(filename);
            fftsamp = fft2(sample);
            % Update MACE to include worst performing
            NewCol = fftsamp(:);
            x = [x NewCol];
            D = (1/(i+1)) * (D + NewCol .* conj(NewCol));
            % Update iDx Matrix
            iDx = [iDx NewCol .* (1.0 ./ D)];
            filter = (iDx / (conj(x') * iDx)) * ones([i+1,1]);
            % Resize for correlation computation
            filter = reshape(filter,orgsize(1),orgsize(2));
        end
    end
    

    %% Save the filter
    mkdir('filters');
    save(fullfile(curr_loc,'filters',...
        ['MACE_' dirname '_' 'filter.mat']),...
        'filter','-mat');
end