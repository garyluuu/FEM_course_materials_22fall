function [u, f] = solve_dsm_truss(msh, femsp, fbc_val)
%SOLVE_DSM_TRUSS Solve for the nodal displacements and reaction forces of a
%truss structure.
%
% Input arguments
% ---------------
%   MSH, FEMSP, FBC_VAL : See notation.m
%
% Output arguments
% -----------------
%   U, F : See notation.m

% Evaluate element stiffness matrices
Ke = eval_unassembled_stiff_truss(msh.transf_data, femsp.EA);

% Assemble element stiffness matrices into global stiffness matrx
K = assemble_nobc_mat_dense(Ke, femsp.ldof2gdof);

% Apply Dirichlet boundary conditions and solve
[u, f] = apply_bc_solve_dsm(K, femsp.dbc.dbc_idx, femsp.dbc.dbc_val, fbc_val);

end