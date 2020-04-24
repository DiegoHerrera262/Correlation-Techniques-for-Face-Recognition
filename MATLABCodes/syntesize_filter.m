% Program for experimenting with funny facil recognition
% Author: Diego Alejandro Herrera
% Date: 24 - 04 - 20
% Description: This function synthesizes a funny filter from 5 images of my
%              face. Not to be taken seriously.

function filter = syntesize_filter(resol, scale_factor, a)
    % Sample filters
    f1 = create_filter('superior.png', resol, scale_factor);
    f2 = create_filter('inferior.png', resol, scale_factor);
    f3 = create_filter('latizq.png', resol, scale_factor);
    f4 = create_filter('latder.png', resol, scale_factor);
    f5 = create_filter('frontal.png', resol, scale_factor);

    % Synthesized filter
    filter = a(1)*f1 + a(2)*f2 + a(2)*f3 + a(4)*f4 + a(5)*f5;
end