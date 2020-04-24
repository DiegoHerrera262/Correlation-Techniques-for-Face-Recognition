% Program for experimenting with funny facil recognition
% Author: Diego Alejandro Herrera
% Date: 24 - 04 - 20
% Description: This code uses a funny filter synthesis algorithm contained
%              in syntehsize_filter.m file. It simply superimposes some
%              filters generated with four images of my face.

function myfilter = create_filter(ref_im, newsize, rsize_fact)
    % Read reference image for filter generation
    ref_image = rgb2gray(imread(ref_im));
    ref_image = imresize(ref_image, rsize_fact);
    % Generate simple reference image of correc size
    Myfilter = zeros(newsize, 'uint8');
    [ref_sizex, ref_sizey] = size(ref_image);
    for i = 1:ref_sizex
        for j = 1:ref_sizey
            Myfilter(i,j) = ref_image(i,j);
        end
    end
    myfilter = conj(fftshift(fft2(Myfilter)));
end