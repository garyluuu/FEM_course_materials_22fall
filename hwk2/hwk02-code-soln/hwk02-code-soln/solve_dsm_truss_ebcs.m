function [u, f] = solve_dsm_truss_ebcs(msh, femsp, fbc_val, ebc_idx, ebc_val)
%SOLVE_DSM_TRUSS_EBCS Solve for the nodal displacements and reaction forces
%of a truss structure, potentially with elastic boundary conditions.
%
% Input arguments
% ---------------
%   MSH, FEMSP, FBC_VAL, EBC_IDX, EBC_VAL : See notation.m
%
% Output arguments
% -----------------
%   U, F : See notation.m

% Evaluate element stiffness matrices
Ke = eval_unassembled_stiff_truss(msh.transf_data, femsp.EA);

% Assemble element stiffness matrices into global stiffness matrx
K = assemble_nobc_mat_dense(Ke, femsp.ldof2gdof);
for k = 1:numel(ebc_idx)
    K(ebc_idx(k), ebc_idx(k)) = K(ebc_idx(k), ebc_idx(k))+ebc_val(k);
end

% Apply Dirichlet boundary conditions and solve
[u, f] = apply_bc_solve_dsm(K, femsp.dbc.dbc_idx, femsp.dbc.dbc_val, fbc_val);
f(ebc_idx) = -ebc_val.*u(ebc_idx);

end