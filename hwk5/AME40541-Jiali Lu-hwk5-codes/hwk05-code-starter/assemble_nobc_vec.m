function [v] = assemble_nobc_vec(ve, ldof2gdof)
%ASSEMBLE_NOBC_VEC Assemble element vectors into a global vector without
%applying Dirichlet/essential boundary conditions.
%
%Input arguments
%---------------
%  VE : Array (NDOF_PER_ELEM, NELEM): Element vector for all elements
%
%  LDOF2GDOF : See notation.m
%
%Output arguments
%----------------
%   V : Array (NDOF,) : Assembled vector PRIOR to static condensation

% Extract quantities
N = max(ldof2gdof(:));
nelem = size(ve, 2);

% Preallocate V
v = zeros(N, 1);

% TODO: Finish!
for e=1:nelem
    idx=ldof2gdof(:,e);
    v(idx, 1) = v(idx, 1) + ve(:, e);
end
end