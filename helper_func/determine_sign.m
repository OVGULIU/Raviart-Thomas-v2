function [ sign_matrix ] = determine_signs( edge2element ,noedges)
% return matrix of signs that tells the sign of node1 -> node2 (sign_matrix(node1,node2)) 
sign_matrix = zeros(noedges,noedges);

for i=1:size(edge2element)
    edge1 = edge2element(i,1);
    edge2 = edge2element(i,2);
    
    sign_matrix(edge1,edge2) = 1;
    
    value = 1;
    
    if (edge2element(i,4) ~=0 )
        value = -1;
    end
    
    sign_matrix(edge2,edge1) = value;

end

