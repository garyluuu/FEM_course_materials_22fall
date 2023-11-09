function [Tv, Tvf] = create_elem_basis(nvar, Qv, Qvf)
%CREATE_ELEM_BASIS Create element basis evaluated at point throughout
%volume (TV) and on each face (TVF) from basis of local function space
%evaluated at corresponding points (QV, QVF).
%
% Input arguments
% ---------------
%   NVAR, QV, QVF : See notation.m
%
% Output arguments
% ----------------
%   TV, TVF : See notation.m

% Extract information from input
ndim = size(Qv, 2)-1;
[nv, ~, nq] = size(Qv);
[~, ~, nqf, nf] = size(Qvf);

% Solution basis
Tv = zeros(nv*nvar, nvar, ndim+1, nq);
Tvf = zeros(nv*nvar, nvar, ndim+1, nqf, nf);
for k = 1:nvar
    Tv(k:nvar:end, k, :, :) = Qv;
    Tvf(k:nvar:end, k, :, :, :) = Qvf;
end

end