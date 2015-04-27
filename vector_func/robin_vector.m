function [ VECTOR ] = robin_vector(coordinates,nodes2edge,u_0,noedges,exterioredges )
%ROBIN_VECTOR Summary of this function goes here
%   Detailed explanation goes here
VECTOR = zeros(noedges,1);

noExt = size(exterioredges,1);

for i=1:noExt
    node1 = exterioredges(i,1);
    node2 = exterioredges(i,2);
    
    %calculate midpoint between node1 and node2
    midpoint = coordinates(node1,:) + 0.5 * (coordinates(node2,:) - coordinates(node1,:));
    
    VECTOR(nodes2edge(node1,node2)) = u_0(midpoint);
    
end

