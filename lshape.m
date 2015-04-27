clear all

addpath('./helper_func');
addpath('./matrix_func');
addpath('./vector_func');

problemset = 'l-shape';

path = ['./problem_settings/'  problemset  '/'];
addpath(path);


% vertex coordinates
p=[0.0, 1.0, 1.0, 0.0, -1.0, -1.0, -1.0,  0.0; ...   % x
   0.0, 0.0, 1.0, 1.0,  1.0,  0.0, -1.0, -1.0];   % y  

% element vertex numbers and index 
t=[1, 2, 1, 4, 1, 6; ...   % p-nr 1
   2, 3, 4, 5, 6, 7; ...   % p-nr 2
   4, 4, 6, 6, 8, 8; ...   % p-nr 3
   1, 1, 1, 1, 1, 1];      % subdomain index

% boundary edge vertex numbers and index 
e=[1, 2, 3, 4, 5, 6, 7, 8; ...   % p-nr 1
   2, 3, 4, 5, 6, 7, 8, 1; ...   % p-nr 2
   1, 1, 1, 1, 1, 1, 1, 1];      % subboundary index 

level = 4;
% mesh refinement
for i=1:level
    [p, e, t] = refinemesh(p, e, t);
end
coordinates = p';
t = t([1 2 3],:);
elements = t';


% print mesh
figure(1); show_mesh(elements,coordinates); title('mesh');

% generate mesh helper data
[nodes2element,nodes2edge,noedges,edge2element,interioredge,exterioredges] = edge(elements,coordinates);

% calculate the transformations for each triangle
[B_K,b_K,detB_K] = transformations( elements, coordinates );

% calculate signs of the edges
signs = determine_signs(edge2element,noedges);

% Mass matrix
MASS = mass_matrix(elements,coordinates,B_K,b_K,detB_K,signs,noedges, nodes2edge);

% Divergence matrix
DIV = divergence_matrix(elements,noedges,nodes2edge,signs);

% Volume force
b_F = volumeforce_vector(elements,coordinates,@f);

% Robin boundary vector
b_R = robin_vector(coordinates,nodes2edge,@u_0,noedges,exterioredges);

% Construct final matrix
noelements = size(elements,1);
A   =    [MASS,DIV';...
          DIV, zeros(noelements,noelements)];

% Construct final vector
b   =   [b_R;...
         b_F   ];
     
% solution
x = A\b;

% isolate potential
potential = x(noedges+1:end);

figure(2); ShowDisplacement(elements,coordinates,potential);

% Clean up afterwards
rmpath(path)

