function [claw] = Pde0()
%Pde0 A class containing relevant information for PDE0.
%
%Input arguments
%---------------
%   None
%
%Output arguments
%----------------
%   CLAW : See notation.m 

claw = struct('nvar', 1, 'ndim', 1, ...
              'npars', 1, 'srcflux', @eval_pde0_srcflux);

end

function [S, dSdU, dSdQ, F, dFdU, dFdQ] = eval_pde0_srcflux(U, Q, pars)
%EVAL_PDE0_SRCFLUX Evaluate PDE0 source term, flux function and their
%partial derivatives at a point.
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
xsq = pars(1);

% Define flux and source
SF = [-xsq+U, -Q];
S = SF(1, 1);
F = SF(1, 2:end);

% Define partial derivative
dSFdUQ = zeros(neqn, ndim+1, nvar, ndim+1);
dSFdUQ(:, 1, :, 1) = 1;
dSFdUQ(:, 2:end, :, 2:end) = reshape(-1, [neqn, ndim, nvar, ndim]); %dFdq
dSdU = reshape(dSFdUQ(:, 1, :, 1), [neqn, nvar]);
dSdQ = reshape(dSFdUQ(:, 1, :, 2:end), [neqn, nvar, ndim]);
dFdU = reshape(dSFdUQ(:, 2:end, :, 1), [neqn, ndim, nvar]);
dFdQ = reshape(dSFdUQ(:, 2:end, :, 2:end), [neqn, ndim, nvar, ndim]);

end