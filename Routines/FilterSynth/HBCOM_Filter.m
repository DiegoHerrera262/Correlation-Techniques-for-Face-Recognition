%% Program that computes MACE Filter using a Database
% Date : 18 - 06 - 20
% Author: Luis Carlos Duran Neme
% Description: This program takes sample pictures and computes a HBCOM
%              filter using binarization and PCE as in references.
%              dirname is the name of the directory where data is stored.
%              Alignment of images is not implemented yet. Always
%              num_imag > 1 

function usedImages = HBCOM_Filter(dirname,refimag,subspace_size)
    %% Establish location of images
    % In this applications, the trainig samples always contain the
    % substring sample as part of their name.
    
    curr_loc = pwd();                % Current MATLABPATH
    dataFolder = ['/ProcessedDatabase'...
        '/' dirname '_filtered'];    % Name of data folder
    MatchName = '/*sample*.png';     % Sample name of image files
    
    %% Definition of data location
    % This creates a string that contains the system path of location
    
    folderLocation = [curr_loc dataFolder MatchName];
    
    %% Create Directory Object
    
    Data = dir(folderLocation);
    base = Data.folder;
    
    %% Read Reference Image
    % The system path of the image is generated using directory object
    
    refimagpath = [base '/*sample' num2str(refimag) '.png'];
    RefImagLoc = dir(refimagpath);
    fullname = [curr_loc dataFolder '/' RefImagLoc.name];
    sample = imread(fullname);
    
    %% Define variables for filter computation
    fftsamp = fft2(sample);             % Template for coeff optimization
    filter = zeros(size(fftsamp));       % Filter
    totalxcorr = zeros(size(fftsamp));
    
    %% Star training
    % This part implements de HBCOM filter computation. Using the reference
    % image, it generates the filter by computing the coefficients using
    % The PCE of the correlation planes over the training subspace.
    
    disp('Computing HBCOM...');
    usedImages = {fullname};                % Cell of used names
    disp(['Testing image: ' RefImagLoc.name]);
    
    if subspace_size > 1
        %% Compute xcorr over subspace and PCE in each case
        for j = 1:subspace_size
            % read image from training set
            filename = [base '/' Data(j).name];
            im = imread(filename);
            usedImages{end+1} = filename;
            disp(['Used image: ' Data(j).name]);
            % Compute xcorr with template
            fftim = fft2(im);
            corrplane = abs(fftshift(ifft2(...
                conj(fftsamp) .* fftim...
                )));
            % cumulative xcorr
            totalxcorr = totalxcorr + corrplane;
            % Plane energy
            PE = max(corrplane(:))^2;
            % Update filter
            filter = filter + (PE)^(-0.8) * fftim;
        end
        % Total energy
        etot = sum(abs(totalxcorr).^2,'all');
        % Binarize + real
        filter = sign(real(1.0/etot^(-0.8) * filter));
        
        %% Save the filter
        mkdir('filters');
        save(fullfile(curr_loc,'filters',...
            ['HBCOM_' dirname '_' 'filter.mat']),...
            'filter','-mat');
    else
        %% Display error if bad num_imag
        disp('Bad computatation, num_imag must be grater than 1');
        
    end
end