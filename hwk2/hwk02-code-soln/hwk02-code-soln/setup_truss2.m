function [msh, femsp, fbc_val] = setup_truss2(pltit)
%SETUP_TRUSS2 Setup Truss 2 geometry, material properties, boundary
%conditions.
%
% Input arguments
% ---------------
%   PLTIT : bool : Whether to plot truss structure
%
% Output arguments
% -----------------
%   MSH, FEMSP, FBC_VAL : See notation.m

if nargin<1, pltit = false; end

% Truss structure
xcg = [0.0, 1.0, 0.0, 1.0, 1.5; ...
       0.0, 0.0, 1.0, 1.0, 1.0];
e2vcg = [1, 1, 2, 3, 2, 1, 4, 2; ...
         2, 3, 4, 4, 3, 4, 5, 5];
     
% Material properties
EA = [1.0; 2.0; 3.0; 4.0; 5.0; 6.0; 7.0; 8.0];

% Boundary conditions
dbc_idx = [1; 2; 4];
dbc_val = [0.0; 0.0; 0.0];
fbc_val = [0.0; 0.0; 0.0; 0.0; 0.0; 0.0; -0.5];

% Create mesh and finite element space
msh = create_mesh_strct_truss(xcg, e2vcg);
femsp = create_femsp_truss(msh, EA, dbc_idx, dbc_val);

% Plot truss
if pltit
    [ndim, nnode] = size(xcg);
    f = zeros(ndim*nnode, 1);
    fbc_idx = setdiff(1:ndim*nnode, dbc_idx);
    f(fbc_idx) = fbc_val;
    visualize_truss([], msh, [], EA, 1, dbc_idx, f);
end

end