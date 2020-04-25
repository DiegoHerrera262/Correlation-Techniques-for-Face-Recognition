% Program that zerro-padds matrix for consitency
% Date : 24 - 04 - 20
% Author: Diego Alejandro Herrera
% Description: Title is self-explanatory ;)

function newmat = zeropadd(inputmat, newsize)
    [sizex,sizey] = size(inputmat);
    newmat = zeros(newsize);
    newmat(1:sizex,1:sizey) = inputmat; 
end