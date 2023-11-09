function [M] = assemble_nobc_mat_dense(Me, ldof2gdof)
%ASSEMBLE_NOBC_MAT_DENSE Assemble element matrices into a global matrix
%(dense) without applying Dirichlet/essential boundary conditions.
%
%Input arguments
%---------------
%  ME : Array (NDOF_PER_ELEM, NDOF_PER_ELEM, NELEM): Element matrix for
%    all elements in mesh
%
%  LDOF2GDOF : See notation.m
%
%Output arguments
%----------------
%   M : Array (NDOF, NDOF) : Assembled matrix PRIOR to static condensation

% Extract quantities
N = max(ldof2gdof(:));
nelem = size(Me, 3);

% Preallocate M
M = zeros(N, N);

% Assemble over each element
for e = 1:nelem    
    % Update entries in global stiffness matrix
    idx = ldof2gdof(:, e);
    M(idx, idx) = M(idx, idx) + Me(:, :, e);
end

end