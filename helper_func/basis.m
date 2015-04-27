function [ BASIS ] = basis( iP )
%BASIS Summary of this function goes here
%   Detailed explanation goes here

BASIS = zeros(3,2,3);

BASIS(:,:,1) = [    iP(:,1)      iP(:,2)-1     ];
BASIS(:,:,2) = [    iP(:,1)      iP(:,2)       ];
BASIS(:,:,3) = [    iP(:,1)-1    iP(:,2)       ];


end

