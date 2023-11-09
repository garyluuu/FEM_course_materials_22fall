function [msh, femsp, fbc_val] = setup_warren_truss(nseg, pltit)
%SETUP_WARREN_TRUSS Setup Warren truss geometry, material properties,
%boundary conditions.
%
% Input arguments
% ---------------
%   NSEG : number : Number of segments along base of truss
%
%   PLTIT : bool : Whether to plot truss structure
%
% Output arguments
% -----------------
%   MSH, FEMSP, FBC_VAL : See notation.m

if nargin<1, nseg = 8; end
if nargin<2, pltit = false; end

% Define nodes
bottom_x = 0:2:2*nseg;
bottom_ind = 1:nseg+1;

top_x = 1:2:2*nseg;
top_ind = nseg+2:2*nseg+1;

xcg = zeros(2, length(bottom_x)+length(top_x));
xcg(1, :) = [bottom_x, top_x];
xcg(2, :) = [zeros(1, length(bottom_x)), ones(1, length(top_x))];

% Define elements
e2vcg = zeros(2, 4*nseg-1);
e2vcg(1, :) = [bottom_ind(1:end-1), top_ind(1:end-1), ...
               bottom_ind(1:end-1), bottom_ind(2:end)];
e2vcg(2, :) = [bottom_ind(2:end), top_ind(2:end), top_ind, top_ind];

% Define material properties
EA = [2.0*ones(1, nseg), 1.0*ones(1, nseg-1), 0.5*ones(1, 2*nseg)]';

% Define prescribed displacements
dbc_idx = [1; 2; 2*(nseg+1)];
dbc_val = [0; 0; 0];

% Define external forces
[ndim, nnode] = size(xcg);
fbc_idx = setdiff(1:ndim*nnode, dbc_idx);
fbc_val_all = zeros(ndim, nnode);
fbc_val_all(2, 1+ceil(nseg/2)) = -0.01;
fbc_val_all(1, end) = 0.01;
fbc_val = fbc_val_all(fbc_idx)';

% Create mesh and finite element space
msh = create_mesh_strct_truss(xcg, e2vcg);
femsp = create_femsp_truss(msh, EA, dbc_idx, dbc_val);

% Plot truss
if pltit
    f = zeros(ndim*nnode, 1);
    f(fbc_idx) = fbc_val;
    visualize_truss([], msh, [], EA, 1, dbc_idx, f);
end

end