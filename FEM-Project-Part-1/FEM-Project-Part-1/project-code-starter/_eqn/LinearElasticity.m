function [claw] = LinearElasticity(ndim)
%LinearElasticity A class containing relevant information for the
%linear elasticity PDE.
%
%Input arguments
%---------------
%   NDIM : See notation.m
%
%Output arguments
%----------------
%   CLAW : See notation.m 

claw = struct('nvar', ndim, 'ndim', ndim, ...
              'npars', ndim+2, 'srcflux', @eval_linelast_srcflux);

end

function [S, dSdU, dSdQ, F, dFdU, dFdQ] = eval_linelast_srcflux(U, Q, pars)
%EVAL_LINELAST_SRCFLUX Evaluate linear elasticity source term, flux
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

% Extract information from input
ndim = size(Q, 1);

% Define information regarding size of the system
neqn = ndim; ncomp = ndim;

% Extract parameters
lam = pars(1);
mu = pars(2);
f = pars(3:3+ndim-1);

% Define source/flux function
F = -lam*trace(Q)*eye(ndim) - mu*(Q+Q');
S = f;

% Define source/flux function partial derivatives
dSFdUQ = zeros(neqn, ndim+1, ncomp, ndim+1);
for i=1:ndim
    for j=1:ndim
        dSFdUQ(i, 1+i, j, 1+j) = dSFdUQ(i, 1+i, j, 1+j) - lam;
        dSFdUQ(i, 1+j, i, 1+j) = dSFdUQ(i, 1+j, i, 1+j) - mu;
        dSFdUQ(i, 1+j, j, 1+i) = dSFdUQ(i, 1+j, j, 1+i) - mu;
    end
end
dSdU = dSFdUQ(:, 1, :, 1);
dSdQ = squeeze(dSFdUQ(:, 1, :, 2:end));
dFdU = dSFdUQ(:, 2:end, :, 1);
dFdQ = squeeze(dSFdUQ(:, 2:end, :, 2:end));

end