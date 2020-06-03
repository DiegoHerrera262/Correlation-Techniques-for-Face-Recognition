function [pse, location] = PSE(corplane)
    %% Locate vicinity of peak
    % Find peak value and location
    [peak, idx] = max(corplane(:));
    [Y, X] = size(corplane);
    [y, x] = ind2sub(size(corplane),idx);
    % Size of PSE window
    deltax = int16(0.2*X); deltay = int16(0.2*Y);
    % Crop window
    data = corplane(max(y-deltay/2,0):min(y+deltay/2,Y),...
        max(x-deltax/2,0):min(x+deltax/2,X));
    
    %% Compute PSE on window
    pse = (peak - mean(data(:)))/std(data(:));
    location = [x y];
end