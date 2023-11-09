function [x, info] = solve_newtraph(fcn, x0, tol, maxit)
%SOLVE_NEWTRAPH Solve a nonlinear system of equations R(x) = 0 using the
%Newton-Raphson method.
%
%Input arguments
%---------------
%  FCN : fuction : Function that accepts X (Array (m,)) and returns the
%    residual R and Jacobian dRdx of the nonlinear system of equation
%    corresponding to X, i.e., R(X), dRdx(X)
%
%  X0 : Array (m,) : Initial guess for the solution of R(x) = 0
%
%  TOL : number : Convergence tolerance; the system is considered
%    converged when max(abs(R)) < tol
%
%  MAXIT : number : Maximum number of iterations allowed
%
%Output arguments
%----------------
%  X : Array (m,) : Solution of R(x) = 0
%
%  INFO : struct : Convergence information
%    INFO.SUCC : bool : Whether the iterations converged
%    INFO.NIT : number : Number of iteration required
%    INFO.R_NRM : Array (nit+1,) : Norm of residual (inf norm) at each
%      iteration, including initial guess
%    INFO.DX_NRM : Array (nit,) : Norm of Newton step at each iteration

% Pre-allocate convergence information
r_nrm = zeros(1, maxit);
dx_nrm = zeros(1, maxit);

% Initialize Newton iterations
x = x0; [R, dR] = fcn(x);
% X = x0(:);

% Newton iterations
for k = 1:maxit
    % Assess convergence
    nrm = max(abs(R(:)));
    r_nrm(k) = nrm;
    if nrm < tol
        % If converged, define convergence structure before returning
        info = struct('succ', true, 'nit', k-1, 'r_nrm', r_nrm(1:k), 'dx_nrm', dx_nrm(1:k-1));
        return;
    end
    
    % Compute Newton step
    dx = -dR\R;
    
    % Update iteration and store convergence information
    x = x + dx;
    dx_nrm(k) = max(abs(dx(:)));
    
    % Evaluate residual/Jacobian for next iteration
    [R, dR] = fcn(x);
end

% In event of no convergence, setup convergence structure
info = struct('succ', false, 'nit', maxit, 'r_nrm', r_nrm, 'dx_nrm', dx_nrm);

end