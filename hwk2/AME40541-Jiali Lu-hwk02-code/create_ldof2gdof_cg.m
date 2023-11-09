function [ldof2gdof] = create_ldof2gdof_cg(ndof_per_node, e2vcg)
%CREATE_MAP_LDOF_TO_GDOF Create a matrix that maps local degrees of freedom
%for each element to global degrees of freedom (ignoring boundary
%conditions). Assume standard connectivity (no mixed elements).
%
%Input arguments
%---------------
%   NDOF_PER_NODE, E2VCG : See notation.m
%
%Output arguments
%----------------
%    LDOF2GDOF : See notation.m

% Preallocate map from local to global degrees of freedom
[nnode_per_elem, nelem] = size(e2vcg);
ldof2gdof = zeros(ndof_per_node*nnode_per_elem, nelem);

% TODO: Finish me!
for e=1:nelem
    ldof2gdof(:,e)=[e2vcg(1,e)*2-1;e2vcg(1,e)*2;e2vcg(2,e)*2-1;e2vcg(2,e)*2];
end