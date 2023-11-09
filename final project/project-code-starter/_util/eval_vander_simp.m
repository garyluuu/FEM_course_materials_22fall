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
    upsilon = [0 1 2 0 1 0;
        0 0 0 1 1 2];
    M = 6;
elseif ndim ==2 && porder ==3
    upsilon = [0 1 2 3 0 1 2 0 1 0;
        0 0 0 0 1 1 1 2 2 3];
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

dV = zeros(nx,M,ndim);
for p = 1:nx
    for i = 1:M
        for j = 1:ndim
            if upsilon(j,i) == 0
                dV(p,i,j) = 0;
                continue;
            end
            temp = 1;
            for s = 1:ndim
                if s == j
                    continue;
                end
                temp = temp * x(s,p) .^ upsilon(s,i); 
            end        
            dV(p,i,j) = upsilon(j,i) * x(j,p).^(upsilon(j,i)-1) * temp;
        end
    end
end


end
