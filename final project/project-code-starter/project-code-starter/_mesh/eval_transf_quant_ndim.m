function [xq, detG, Gi, xqf, sigf, Gif] = eval_transf_quant_ndim(xe, Qv, Qvf, r2z, f2v)
%EVAL_TRANSF_QUANT_DIM Evaluate transformation quantities for a single
%element given the nodal coordinates of the element in physical space (XE)
%and the basis functions (and their derivatives) of the element.
%
%Input arguments
%---------------
%  XE, QV, QVF, R2Z, F2V : See notation.m

% R2Z : Array (NDIM, (NDIM-1)+1, NQF, NF) : Mapping and its deformation
%    gradient from reference face domain \Gamma_\square to reference volume
%    domain \Omega_\square evaluated at each quadrature node of each face.

% F2V : Array (NVF, NF) : Index array that indicates the nodes that
%   comprise each face, i.e., F2V(:, k) are the local node numbers of the
%   nodes that lie on face k and, similarly, ZK(:, F2V(:, k)) are the
%   nodal positions. NF is the number of faces the element contains
%   (nf=ndim+1) for simplex elements and NVF is the number of nodes on
%   each face of the element.

%Output arguments
%----------------
%  XQ, DETG, GI, XQF, SIGF, GIF : See notation.m

% Extract information from input
ndim = size(xe, 1);
nf = size(f2v, 2);
nx = size(Qv, 3);
nxf = size(Qvf, 3);

% Preallocate arrays
xq = zeros(ndim, nx);
detG = zeros(nx, 1);
% DETG : Array (NQ,) : The determinant of the deformation gradient of the
%    isoparametric mapping, evaluated at each quadrature node, i.e.,
%    DETG(k) = det(G(ZQ(:, k)).
Gi = zeros(ndim, ndim, nx);
% GI : Array (NDIM, NDIM, NQ) : The inverse of the deformation
%    gradient of the isoparametric mapping, evaluated at each quadrature
%    node, i.e., GI(:, :, k) = inv(G(ZQ(:, k)).

xqf = zeros(ndim, nxf, nf);
sigf = zeros(nxf, nf);
% SIGF : Array (NQF, NF) : The surface element corresponding to the
%    isoparametric mapping restricted to each face of the element.
%    See formula in project handout.
Gif = zeros(ndim, ndim, nxf, nf);

% Compute transformation volume terms
% Code me!
for k=1:nx
    xq(:,k)=xe*Qv(:,1,k);
    G=xe*Qv(:,2:end,k);
    Gi(:,:,k)=inv(G);
    detG(k)=det(G);
end

% Compute transformation face terms
for f = 1:nf
    for k = 1:nxf
        xqf(:, k, f) = xe*Qvf(:, 1, k, f);
        Gf = xe*Qvf(:, 2:end, k, f);
        Gif(:, :, k, f) = inv(Gf);
        if ndim == 1, sigf(k, :) = [1, 1]; continue; end
        Ff = Gf*r2z(:, 2:end, k, f);
        sigf(k, f) = sqrt(det(Ff'*Ff));
    end
end

end