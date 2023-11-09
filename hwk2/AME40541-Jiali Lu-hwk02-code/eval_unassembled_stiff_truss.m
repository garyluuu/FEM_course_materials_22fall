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

blank=zeros(2,2);

% TODO: Finish me!
Ke =zeros(ndof_per_elem,ndof_per_elem,nelem);
for e=1:nelem
    L = transf_data(e).L;
    Q = transf_data(e).Q;
    Ke(:,:,e)=EA(e)/L*[Q,blank;blank,Q]'*[1,0,-1,0;0,0,0,0;-1,0,1,0;0,0,0,0]*[Q,blank;blank,Q];
end