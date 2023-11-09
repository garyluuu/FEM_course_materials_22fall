function [claw] = LinearEllipticScalar(ndim)
%LinearEllipticScalar A class containing relevant information for the
%scalar, linear elliptic PDE.
%
%Input arguments
%---------------
%   None
%
%Output arguments
%----------------
%   CLAW : See notation.m 

claw = struct('nvar', 1, 'ndim', ndim, ...
              'npars', ndim^2+1, 'srcflux', @eval_linelptc_sclr_srcflux);

end

function [S, dSdU, dSdQ, F, dFdU, dFdQ] = eval_linelptc_sclr_srcflux(U, Q, pars)
%EVAL_LINELPTC_SCLR_SRCFLUX Evaluate linear elliptic PDE source term, flux
%function and their partial derivatives at a point.
%
%Input arguments
%---------------
%   U : Array (NVAR, 1) : PDE state vector at a point
%
%   Q : Array (NVAR, NDIM) : Gradient of PDE state vector at a point
%
%   PARS : Array (NPARS, 1) : Vector of parameters at a point
%
%Output arguments
%----------------
%   S, dSdU, dSdQ, F, dFdU, dFdQ : See notation.m

% Define information regarding size of the system
neqn = 1; nvar = 1;

% Extract information from input
ndim = numel(Q);
k = reshape(pars(1:ndim^2), [ndim, ndim]);
f = pars(ndim^2+1);

% Define flux and source
SF = [f, -(k*Q(:))'];
S = SF(1, 1);
F = SF(1, 2:end);

% Define partial derivative
dSFdUQ = zeros(neqn, ndim+1, nvar, ndim+1);
dSFdUQ(:, 2:end, :, 2:end) = reshape(-k, [neqn, ndim, nvar, ndim]); %dFdq
dSdU = reshape(dSFdUQ(:, 1, :, 1), [neqn, nvar]);
dSdQ = reshape(dSFdUQ(:, 1, :, 2:end), [neqn, nvar, ndim]);
dFdU = reshape(dSFdUQ(:, 2:end, :, 1), [neqn, ndim, nvar]);
dFdQ = reshape(dSFdUQ(:, 2:end, :, 2:end), [neqn, ndim, nvar, ndim]);

end