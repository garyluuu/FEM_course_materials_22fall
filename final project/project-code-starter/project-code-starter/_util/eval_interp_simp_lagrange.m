function [Q] = eval_interp_simp_lagrange(xk, x)
%EVAL_INTERP_SIMP_LAGRANGE Evaluate interpolation functions for simplex
%using Lagrange polynomials (number of spatial dimensions and polynomial
%degree of completeness determined from the nodes of the element XK).
%
%Input arguments
%---------------
%   XK0 : Array (NV0,) : Nodes at which Lagrange polynomials interpolate
%    values (nodes defining Lagrange polynomials) in each dimension.
%
%   X : Array (NDIM, NX) : Points at which Lagrange polynomials are
%     evaluated. 
%
%Output arguments
%----------------
%   Q : Array (NV, NDIM+1, NX) : Lagrange interpolation functions (NV) and
%     their derivative evaluated at each point in X. Q(i, 1, j) = value of
%     ith interpolation function evaluated at X(:, j), i.e., Q(i, 1, j) =
%     phi_i(X(j)). Q(i, 1+k, j) = kth partial derivative of ith
%     interpolation function evaluated at X(:, j), i.e., Q(i, 1+k, j) =
%     d(phi_i)/d(x_k))(X(:, j).

% Extract information from input
[ndim, nv] = size(xk);
nx = size(x, 2);

% Handle case where ndim == 0 as special case, assuming nv = nx = 1
if ndim == 0
    Q = ones(1, 1, 1);
    return;
end

% Handle case where nv == 1 (porder == 0)
if nv == 1
    Q = zeros(nv, ndim+1, nx);
    Q(:, 1, :) = 1;
    return;
end

% Determine polynomial order
porder = 0;
while true
    nv0 = nchoosek(porder+ndim, ndim);
    if nv0 == nv, break; end
    porder = porder+1;
end

% Code me!
% Find Phi

 [Vhat,d_Vhat] = eval_vander_simp(porder,xk);
 [Vtilde,d_Vtilde] = eval_vander_simp(porder,x);
 Vhat_inv = inv(Vhat);
 
 
for i = 1:nv
    for j = 1:nx
        Q(i,1,j) = 0;
        for k = 1:nv
        
        Q(i,1,j) = Q(i,1,j) + ((Vhat_inv(k,i))* (Vtilde(j,k)));
        end
    end
end


% Find Dphi
for i = 1:nv
    for j = 1:nx
        for k = 1:ndim
            Q(i,1+k,j) = 0;
            for l = 1:nv
                
                Q(i,1+k,j) = Q(i,1+k,j) + ((Vhat_inv(l,i))* (d_Vtilde(j,l,k)));
                
            end
        end
    end
end




end