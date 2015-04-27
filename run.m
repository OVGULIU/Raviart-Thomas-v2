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
boundary = load([path 'boundary.dat']);

% print mesh
figure(1); show_mesh(elements,coordinates); title('mesh');

% generate mesh helper data
[nodes2element,nodes2edge,noedges,edge2element,interioredge] = edge(elements,coordinates);

% calculate the transformations for each triangle
[B_K,b_K,detB_K] = transformations( elements, coordinates );

% calculate signs of the edges
signs = determine_sign(edge2element,noedges);

% Mass matrix
MASS = mass_matrix(elements,coordinates,B_K,b_K,detB_K,signs,noedges, nodes2edge);

% Clean up afterwards
rmpath(path)

