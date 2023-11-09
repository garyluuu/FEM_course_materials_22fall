function [Ke, fe] = intg_elem_stiff_load_pde0(xe)
%INTG_ELEM_STIFF_LOAD_PDE0 Evaluate the stiffness matrix and load
%vector for PDE0 element in 1D using linear Lagrange basis.
%
%   PDE : -u'' - u + x^2 = 0,  0 < x < 1
%   BCs :  u(0) = 0, u'(1) = 1
%
%   Basis: phi1 = (x2-x)/(x2-x1)
%          phi2 = (x-x1)/(x2-x1)
%
%Input arguments
%---------------
%   XE : Array (NDIM, NNODE_PER_ELEM) : Coordinates of element nodes
%
%Output arguments
%----------------
%   KE : Array (NDOF_PER_ELEM, NDOF_PER_ELEM) : Element stiffness matrix
%
%   FE : Array (NDOF_PER_ELEM,) : Element load vector

% Extract information from input
x1 = xe(1, 1);
x2 = xe(1, 2);
he = x2-x1;

% Stiffness matrix:
% Ke(i, j) = \int_{x_1}^{x_2} [ d(phi_i)/dx * d(phi_j)/dx - phi_i*phi_j] * dx
Ke = (1/he)*[1, -1; -1, 1]-(he/6)*[2, 1; 1, 2];

% Force vector:
% Fe(i) = -\int_{x_1}^{x_2} phi_i * x^2 * dx + phi_i(L)
fe = -(he/12)*[3*x1^2+2*x1*x2+x2^2; x1^2+2*x1*x2+3*x2^2];

if x2>1-1.0e-14
    fe(2) = fe(2) + 1.0;
end

end