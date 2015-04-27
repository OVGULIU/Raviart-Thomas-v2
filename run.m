clear all

addpath('./helper_func');
addpath('./matrix_func');
addpath('./vector_func');

problemset = 'twotriangles';
%problemset = 'l-shape';

path = ['./problem_settings/'  problemset  '/'];
addpath(path);
coordinates = load([path  'coordinates.dat']);
elements = load([path  'elements.dat']);


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

