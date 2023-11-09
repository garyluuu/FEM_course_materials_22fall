function [R, dR] = eval_assembled_resjac_claw_cg(U, transf_data, elem, elem_data, ...
                                                 ldof2gdof, spmat)
%EVAL_ASSEMBLED_RESJAC_CLAW_CG Evaluate assembled residual vector and
%Jacobian matrix
%
%Input arguments
%---------------
%   U : Array (NDOF,) : Global (assembled) solution vector
%
%   TRANSF_DATA, ELEM, ELEM_DATA, SPMAT : See notation.m
%
%Output arguments
%----------------
%   R : Array (NDOF,) : Assembled residual vector PRIOR to static condensation
%
%   dR : Array (NDOF, NDOF) : Assembled Jacobian matrix PRIOR to static condensation

% Code me!
[Re, dRe] = eval_unassembled_resjac_claw_cg(U, transf_data, elem, elem_data, ldof2gdof);
nelem = size(transf_data,1);
ndof = max(ldof2gdof(:));
R=zeros(ndof,1);

inz = size(spmat.cooidx,1);

dR = zeros(inz, 1);


for e=1:nelem
    idx=ldof2gdof(:,e);
    R(idx)=R(idx)+Re(:,e);
    idx_sp=spmat.lmat2gmat(:,:,e);
    dR(idx_sp)=dR(idx_sp)+dRe(:,:,e);
end

dR = sparse(spmat.cooidx(:,1), spmat.cooidx(:,2), dR);

end