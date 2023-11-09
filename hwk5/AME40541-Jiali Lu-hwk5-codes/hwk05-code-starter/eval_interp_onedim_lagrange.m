function [Q] = eval_interp_onedim_lagrange(xk, x)
%EVAL_INTERP_ONEDIM_LAGRANGE Evaluate Lagrange interpolation functions on
%interval (XK(1), XK(end)) associated with nodes XK (number of nodes = nv)
%at points X (number of points = NX).
%
%Input arguments
%---------------
%   XK : Array (NV,) : Nodes at which Lagrange polynomials interpolate
%    values (nodes defining Lagrange polynomials).
%
%   X : Array (NX,) : Points at which Lagrange polynomials are evaluated.
%
%Output arguments
%----------------
%   Q : Array (NV, 2, NX) : Lagrange interpolation functions (Q(:, 1, :))
%     and their derivatives (Q(:, 2, :)) evaluated at each point in X.
%     That is, Q(i, 1, j) = Lagrange interpolation function associated
%     with node xk(i) evaluated at point x(j). Similarly, Q(i, 2, j) =
%     derivative of Lagrange interpolation function associated with node
%     xk(i) evaluated at point x(j).

% Extract information from input, ensure xk and x appropriately shaped
nv = numel(xk);
nx = numel(x);
xk = xk(:); x = x(:);

% TODO: Finish me!
for j=1:nx
    for i=1:nv
        Q(i,1,j)=1;
        for k=1:nv
            if k~=i
                Q(i,1,j)=Q(i,1,j)*(x(j)-xk(k))/(xk(i)-xk(k)); 
            end
        end
    end
end

for j=1:nx
    for i=1:nv
        Q(i,2,j)=0;
        for k=1:nv
            temp1=1;
            for n=1:nv
                if(n~=i && n~=k)
                    temp1=(x(j)-xk(n))/(xk(i)-xk(n));
                end
            end
            temp1=temp1/(xk(k)-xk(n));
            if(k~=i)
                Q(i,2,j)=Q(i,2,j)+temp1;
            end
        end
    end
end
