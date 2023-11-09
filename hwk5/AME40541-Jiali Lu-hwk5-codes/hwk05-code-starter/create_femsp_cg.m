function [femsp] = create_femsp_cg(msh, dbc_idx, dbc_val)
%CREATE_FEMSP_CG Create "finite element space" containing boundary
%condition information and degree of freedom connectivity.
%
% Input arguments
% ---------------
%   MSH, DBC_IDX, DBC_VAL : See notation.m
%
% Output arguments
% -----------------
%   FEMSP : See notation.m

% Create sparsity structure
ldof2gdof = create_ldof2gdof_cg(1, msh.e2vcg);

% Create empty Dirichlet boundary conditions
ndof = max(ldof2gdof(:));
dbc = create_dbc_strct(ndof, dbc_idx, dbc_val);

% Finite element space
femsp = struct('ldof2gdof', ldof2gdof, 'dbc', dbc);

end