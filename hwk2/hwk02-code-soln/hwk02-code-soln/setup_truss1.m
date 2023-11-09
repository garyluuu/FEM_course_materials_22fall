function [msh, femsp, fbc_val, ebc_idx, ebc_val] = setup_truss1(pltit)
%SETUP_TRUSS1 Setup Truss 1 geometry, material properties, boundary
%conditions.
%
% Input arguments
% ---------------
%   PLTIT : bool : Whether to plot truss structure
%
% Output arguments
% -----------------
%   MSH, FEMSP, FBC_VAL : See notation.m

if nargin < 1, pltit = true; end

% Define truss and boundary conditions
xcg = [0.0, 1.0, 0.0, 1.0; ...
       0.0, 0.0, 1.0, 1.0];
e2vcg = [1, 1, 2, 3, 1; ...
         2, 3, 4, 4, 4];
EA = [1.0; 2.0; 3.0; 4.0; 5.0];

dbc_idx = [1; 2];
dbc_val = [0.0; 0.0];

% fbc_idx = [3; 4; 5; 6; 7; 8];
fbc_val = [0.0; 0.0; 0.0; 0.0; 0.1; 0.0];

ebc_idx = 4;
ebc_val = 1.0;

% Create mesh and finite element space
msh = create_mesh_strct_truss(xcg, e2vcg);
femsp = create_femsp_truss(msh, EA, dbc_idx, dbc_val);

% Plot truss and boundary conditions
if pltit
    [ndim, nnode] = size(xcg);
    f = zeros(ndim*nnode, 1);
    fbc_idx = setdiff(1:ndim*nnode, dbc_idx);
    f(fbc_idx) = fbc_val;
    visualize_truss([], msh, [], EA, 1, dbc_idx, f);
end

end