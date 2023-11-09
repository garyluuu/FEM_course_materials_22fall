function [u] = solve_fem_dense(msh, femsp, intg_elem_stiff_load)
%SOLVE_FEM_DENSE Approximate the solution of a PDE by solving for the nodal
%degrees of freedom on a mesh using the finite element method.
%
% Input arguments
% ---------------
%   MSH, FEMSP : See notation.m
%
%   INTG_ELEM_STIFF_LOAD : Function handle that evaluates elementwise
%      stiffness matrix and load vector
%
% Output arguments
% -----------------
%   U : See notation.m

% Extract information from input
xcg = msh.xcg;
e2vcg = msh.e2vcg;
ldof2gdof = femsp.ldof2gdof;
dbc_idx = femsp.dbc.dbc_idx;
dbc_val = femsp.dbc.dbc_val;

% TODO: Finish!
[Ke, fe] = eval_unassembled_stiff_load(xcg, e2vcg, intg_elem_stiff_load);
K = assemble_nobc_mat_dense(Ke, ldof2gdof);
F = assemble_nobc_vec(fe, ldof2gdof);
u = apply_dbc_solve_fem(K, F, dbc_idx, dbc_val);
end