function [ VECTOR ] = volumeforce_vector( elements, coordinates,f )
%F_VECTOR Summary of this function goes here
%   Detailed explanation goes here
numberOfElements = size(elements,1);

VECTOR = zeros(numberOfElements,1);

for l = 1:numberOfElements
    VECTOR(l) = - 0.5 * det([1,1,1; coordinates(elements(l,:),:)']) ...
        * f(sum(coordinates(elements(l,:),:))/3);
end

end

