function [ DIVER ] = divergence_matrix( elements, noedges ,nodes2edge,signs)
%DIVERGENCE_MATRIX Summary of this function goes here
%   Detailed explanation goes here

numberOfElements = size(elements,1);

DIVER = zeros(numberOfElements,noedges);

mapping = [1 2; 2 3; 3 1];

for l=1:numberOfElements
    for i=1:3
       % extract edges in order 
       node1 = elements(l,mapping(i,1));
       node2 = elements(l,mapping(i,2));
       edge  = nodes2edge(node1,node2);
       DIVER(l,edge) = signs(node1,node2);
    end
    
end
end

