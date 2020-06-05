function [pse, location] = PSE(corplane)
    %% Locate vicinity of peak
    % Find peak value and location
    [peak, idx] = max(corplane(:));
    [Y, X] = size(corplane);
    [y, x] = ind2sub(size(corplane),idx);
    % Size of PSE window
    deltax = int16(0.4*X); deltay = int16(0.4*Y);
    % Crop window
    y_lim = max(y-deltay,1):min(y+deltay,Y);
    x_lim = max(x-deltax,1):min(x+deltax,X);
    data = corplane(...
        y_lim,...
        x_lim);
    
    %% Compute PSE on window
    pse = (peak - mean(data(:)))/std(data(:));
    location = [x y];
end