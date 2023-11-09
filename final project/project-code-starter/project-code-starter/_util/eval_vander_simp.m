function [V, dV] = eval_vander_simp(porder, x)
%VANDER_SIMP Compute NDIM-dimensional Vandermonde matrix of order PORDER
%for a  simplex and its derivative (NDIM determined from shape of X). The
%Vandermonde matrix, V, is the NX x M matrix  of multinomial terms and its
%derivative, dV, is the NX x M x NDIM matrix of the partial derivatives of
%multinomial terms, where M is the number of multinomial terms required for
%polynomial completeness (all combinations such that the sum of the
%exponents is <= porder), and X are the evaluation points.
%
%Input arguments
%---------------
%   PORDER : Polynomial degree of completeness
%
%   X : Array (NDIM, NX) : Points at which to evaluate multinomials in
%     definition of Vandermonde matrix 
%
%Output arguments
%----------------
%   V : Array (NX, M) : Vandermonde matrix
%
%   dV : Array (NX, M, NDIM) : Derivative of Vandermonde matrix

% Extract information from input
[ndim, nx] = size(x);

if ndim ==1 && porder ==1
    upsilon = [0 1];
    M=2;
elseif ndim ==1 && porder ==2
    upsilon = [0 1 2];
    M=3;
elseif ndim ==1 && porder ==3
    upsilon = [0 1 2 3];
    M=4;
elseif ndim ==2 && porder ==1
    upsilon = [0 1 0; 0 0 1];
    M = 3;
elseif ndim ==2 && porder ==2
    upsilon = [0 1 0 2 1 0; 
               0 0 1 0 1 2];
    M = 6;
elseif ndim ==2 && porder ==3
    upsilon = [0 1 0 2 1 0 0 1 2 3;
               0 0 1 0 1 2 3 2 1 0];
    M=10;
end

% Code me!

V = ones(nx,M);
for i = 1:nx
    for j = 1:M
        for s = 1:ndim
            V(i,j) = V(i,j)*x(s,i)^upsilon(s,j);
        end
    end
end


dV = ones(nx,M,ndim);
for i = 1:nx
    for j = 1:M
        for s = 1:ndim
            if(upsilon(s,j) == 0)
                dV(i,j,s) = 0;
            elseif s==j
                dV(i,j,s) = dV(i,j,s)*upsilon(i,j)*x(i,j)^(upsilon(i,j)-1);
            else
                dV(i,j,s) = dV(i,j,s)*x(s,i)^upsilon(s,j);
            end
        end
    end
end

end