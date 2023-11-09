function  [u] = apply_dbc_solve_fem(K, F, dbc_idx, dbc_val)
%APPLY_DBC_SOLVE_FEM Apply Dirichlet boundary conditions via static
%condensation.
%
%Input arguments
%---------------
%   K : Array (NDOF, NDOF) : assembled stiffness matrix
%
%   F : Array (NDOF,) : assembled force vector
%
%   DBC_IDX, DBC_VAL : See notation.m
%
%Output arguments
%----------------
%   U : See notation.m

% Define indices of force BCs from indices of Dirichlet BCs
ndof = size(K, 1);
free_idx = setdiff(1:ndof, dbc_idx);

free_val=F(free_idx);

% TODO: Finish me!
Kff = K(free_idx, free_idx);
Kfd = K(free_idx, dbc_idx);
Kdf = K(dbc_idx, free_idx);
Kdd = K(dbc_idx, dbc_idx);

uf = Kff\(free_val-Kfd*dbc_val);

u(free_idx)=uf;
u(dbc_idx)=dbc_val;
end