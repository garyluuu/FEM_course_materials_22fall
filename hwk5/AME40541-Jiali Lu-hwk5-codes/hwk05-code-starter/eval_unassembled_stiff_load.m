function [Ke, fe] = eval_unassembled_stiff_load(xcg, e2vcg, intg_elem_stiff_load)
%EVAL_UNASSEMBLED_STIFF_LOAD Evaluate/store stiffness matrix and load
%vector for each element.
%
% Input arguments
% ---------------
%   XCG, E2VCG : See notation.m
%
%   INTG_ELEM_STIFF_LOAD : Function handle that evaluates elementwise
%      stiffness matrix and load vector from coordinates of element nodes
%      (XE).
%
% Output arguments
% -----------------
%   KE : Array (NDOF_PER_ELEM, NDOF_PER_ELEM, NELEM): unassembled element
%     stiffness matrices (KE(:, :, e) - stiffness matrix of element e).
%
%   FE : Array (NDOF_PER_ELEM, NELEM): unassembled load vectors
%     (FE(:, :, e) - load vector of element e).

% Extract information from input
[nnode_per_elem, nelem] = size(e2vcg);
ndof_per_elem = nnode_per_elem;

% Evaluate unassembled stiffness matrix
Ke = zeros(ndof_per_elem, ndof_per_elem, nelem);
fe = zeros(ndof_per_elem, nelem);

% TODO: Finish me!
% loop over elements
% extract xe (nodes for element e)
% YES: [KeE, feE] = intg_elem_stiff_load(xe);
% NO: [KeE, feE] = intg_elem_stiff_load_pde0(xe);


for i=1:nelem
    for j=1:nnode_per_elem
        xe(:,j)=xcg(:,e2vcg(j,i));
    end
    [KeE, feE] = intg_elem_stiff_load(xe);
    Ke(:,:,i)=KeE;
    fe(:,i)=feE;
end

end