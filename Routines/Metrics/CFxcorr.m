function corplane = CFxcorr(test_im,filtername,filtertype)
    %% Read MACE Filter from directory
    Filter = load(['filters/' ...
        filtertype '_' filtername '_filter.mat']);
    Filter = Filter.filter;
    
    %% Compute Correlation
    % Compute correlation
    fft_testim = fft2(test_im);
    fft_cor = fft_testim .* conj(Filter);
    corplane = 1e6*abs(fftshift(ifft2(fft_cor)));
end