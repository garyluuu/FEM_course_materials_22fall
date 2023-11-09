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

% Partition residual and Jacobian into fix/free dofs
Kff = K(fbc_idx, fbc_idx);
Kfd = K(fbc_idx, dbc_idx);
Kdf = K(dbc_idx, fbc_idx);
Kdd = K(dbc_idx, dbc_idx);

% Solve for nodal displacements and reaction forces
uf = Kff\(fbc_val-Kfd*dbc_val);
fd = Kdf*uf+Kdd*dbc_val;

% Re-assemble displacement and force vectors
u = zeros(ndof, 1);
u(dbc_idx) = dbc_val;
u(fbc_idx) = uf;

f = zeros(ndof, 1);
f(dbc_idx) = fd;
f(fbc_idx) = fbc_val;

end
