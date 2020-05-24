function [pse, location] = PSE(corplane)
    %% Locate vicinity of peak
    % Find peak value and location
    [peak, idx] = max(corplane(:));
    [y, x] = ind2sub(size(corplane),idx);
    % Size of PSE window
    deltax = 40; deltay = 40;
    % Crop window
    data = corplane(y-deltay/2:y+deltay/2,...
        x-deltax/2:x+deltax/2);
    
    %% Compute PSE on window
    pse = (peak - mean(data(:)))/std(data(:));
    location = [x y];
end