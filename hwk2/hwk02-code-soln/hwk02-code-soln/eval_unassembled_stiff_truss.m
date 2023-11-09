function [Ke] = eval_unassembled_stiff_truss(transf_data, EA)
%EVAL_UNASSEMBLED_STIFF_TRUSS Evaluate/sotre stiffness matrix for each
%element.
%
% Input arguments
% ---------------
%   TRANSF_DATA, EA : See notation.m
%
% Output arguments
% -----------------
%   KE : Array (NDOF_PER_ELEM, NDOF_PER_ELEM, NELEM):
%     unassembled element stiffness matrices (KE(:, :, e) is the stiffness
%     matrix of element e).

% Extract information from input
ndim = size(transf_data(1).Q, 1);
ndof_per_elem = 2*ndim;
nelem = numel(EA);

% Evaluate unassembled stiffness matrix
Ke = zeros(ndof_per_elem, ndof_per_elem, nelem);
for e = 1:nelem
    Ke(:, :, e) = intg_elem_stiff_truss(transf_data(e), EA(e));
end

end