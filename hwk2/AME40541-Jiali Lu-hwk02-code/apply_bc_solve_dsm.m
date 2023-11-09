function  [u, f] = apply_bc_solve_dsm(K, dbc_idx, dbc_val, fbc_val)
%APPLY_BC_SOLVE_DSM Apply boundary conditions via static condensation and
%solve for unknown displacements and reaction forces.
%
%Input arguments
%---------------
%   K : 2D array (NDOF, NDOF) : assembled stiffness matrix
%
%   DBC_IDX, DBC_VAL, FBC_VAL : See defintion in notation.m
%
%Output arguments
%----------------
%   U, F : See defintion in notation.m

% Define indices of force BCs from indices of Dirichlet BCs
ndof = size(K, 1);
fbc_idx = setdiff(1:ndof, dbc_idx);

% TODO: Finish me!
uc=dbc_val;
uu=zeros(length(fbc_idx),1);
u=zeros(ndof,1);
u(1:length(fbc_idx))=uu;
u(length(fbc_idx)+1:ndof)=uc;

fc=zeros(length(dbc_idx),1);
fu=fbc_val;
f=zeros(ndof,1);
f(1:length(fbc_idx))=fu;
f(length(fbc_idx)+1:ndof)=fc;
end
