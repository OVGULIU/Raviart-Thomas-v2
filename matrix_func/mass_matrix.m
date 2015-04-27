function [ MASS ] = mass_matrix( elements,coordinates,B_K,b_k,detB_K,signs,noedges, nodes2edge )
%MASS_MATRIX Summary of this function goes here
%   Detailed explanation goes here

numberOfElements = size(elements,1);
detB_K = abs(detB_K);

% define integration points and weights for unit triangle
ip = [1.66666666666666e-01  6.66666666666667e-01;
   6.66666666666667e-01     1.66666666666667e-01;
   1.66666666666667e-01     1.66666666666666e-01];

weight = ones(3,1).*1.66666666666667e-01;

MASS=zeros(noedges,noedges);

BASIS = basis(ip);

mapping = [1 2; 2 3; 3 1];

for i=1:numberOfElements
    for j=1:3
       % extract edges in order 
       node1_out = elements(i,mapping(j,1));
       node2_out = elements(i,mapping(j,2));
       edge_out  = nodes2edge(node1_out,node2_out);
       for k=j:3
        node1_in = elements(i,mapping(k,1));
        node2_in = elements(i,mapping(k,2));
        edge_in  = nodes2edge(node1_in,node2_in);
        %integration loop
        for int=1:3;
         MASS(edge_out,edge_in) = MASS(edge_out,edge_in) + ...
             weight(int) * detB_K(i)^(-1) + ...
             sum( (signs(node1_out,node2_out) * B_K(:,:,i) * BASIS(int,:,j)') ...
                  .* ...
                  (signs(node1_in,node2_in)   * B_K(:,:,i) * BASIS(int,:,k)') ...  
                ); 
        end
         % since MASS is symmetric....
         MASS(edge_in,edge_out) = MASS(edge_out,edge_in); 
       end
    end
end

end

