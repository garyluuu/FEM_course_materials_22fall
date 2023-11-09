function [femsp] = create_femsp_truss(msh, EA, dbc_idx, dbc_val)
%CREATE_FEMSP_TRUSS Create "finite element space" for truss structure that
%contains relevant information about element properties, global
%connectivity, and boundary conditions.
%
% Input arguments
% ---------------
%   MSH, EA, DBC_IDX, DBC_VAL : See notation.m
%
% Output arguments
% -----------------
%   FEMSP : See notation.m

% Extract information from input
ndim = size(msh.xcg, 1);

% Create sparsity structure
ldof2gdof = create_ldof2gdof_cg(ndim, msh.e2vcg);

% Create empty Dirichlet boundary conditions
ndof = max(ldof2gdof(:));
dbc = create_dbc_strct(ndof, dbc_idx, dbc_val);

% Finite element space
femsp = struct('EA', EA, 'ldof2gdof', ldof2gdof, 'dbc', dbc);

end