% Program that takes pictures and saves them in current directory
% Date : 02 - 05 - 20
% Author: Diego Alejandro Herrera
% Description: This program takes sample pictures and computes a MACE
%              filter using matrix multiplication as in references.

function MACE_Filter(dirname,m,n)
    %% Establish location of images
    basedir = pwd();
    images = dir([basedir '/' dirname]);
    filename = [basedir '/' dirname '/' images(3).name];
    
    %% Read image for size reference for filter
    im = fftshift(fft2(rgb2gray(imread(filename)),m,n));
    % original size
    orsize = size(im);
    % Matrix with images in Fourier Space
    ref = size(im(:));
    X = zeros(ref(1),numel(images)-2);
    % For more efficient matrix multiplication
    iDX = zeros(size(X));
    % Mean Power Spectra
    P = im(:) .* conj(im(:)) * 1.0/(numel(images)-2);
    % Vector of predefined values
    u = ones([numel(images)-2,1]);
    
    %% Generating matrixes for filter computation
    for i = 3:numel(images)
        % Read image from directory
        filename = [basedir '/' dirname '/' images(i).name];
        im = double(rgb2gray(imread(filename)));
        % Normalize Image
        s = size(im);
        im = reshape(normalize(im(:)),s(1),s(2));
        im = fftshift(fft2(im,m,n));
        % Update matrix of images
        X(:,i-2) = im(:);
        % Update Power Spectra Matrix
        P = P + im(:) .* conj(im(:)) * 1.0/(numel(images)-2);
    end
    
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
    
    %% Save the filter
    mkdir('filters');
    save(fullfile(basedir,'filters',[dirname '_' 'filter.mat']),'filter','-mat');
end