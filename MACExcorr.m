function corplane = MACExcorr(test_im,filtername)
    %% Read MACE Filter from directory
    Filter = load(['filters/' filtername '_filter.mat']);
    Filter = Filter.filter;
    
    %% Compute Correlation
    % Normalize test image
    s = size(test_im);
    testim = double(test_im(:));
    testim = reshape(normalize(testim),s(1),s(2));
    % Compute correlation
    fft_testim = fft2(testim);
    fft_cor = fft_testim .* conj(Filter);
    corplane = abs(fftshift(ifft2(fft_cor)));
end