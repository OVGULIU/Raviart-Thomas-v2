function [B_K,b_K,detB_K] = transformations( elements, coordinates )

numberOfElems = size(elements,1);
B_K = zeros(2,2,numberOfElems);

% each row of P* contains the coordinates of a triangle point
P1 = coordinates(elements(:,1),1:2);
P2 = coordinates(elements(:,2),1:2);
P3 = coordinates(elements(:,3),1:2);

% calculate the vectors that define the triangles
a = P2 - P1;
b = P3 - P1;

% assemble the mapping F_K = B_K * x + b_k
B_K(:,1,:)  = a';
B_K(:,2,:)  = b';
b_K         = P1;

% calculate determinant
detB_K = a(:,1).*b(:,2) - a(:,2).*b(:,1);

end