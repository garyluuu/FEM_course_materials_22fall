function [Ke, fe] = intg_elem_stiff_load_pde1(xe)
%INTG_ELEM_STIFF_LOAD_PDE1 Evaluate the stiffness matrix and load
%vector for PDE1 element in 2D using linear Lagrange basis.
%
%   PDE : -T_{,ii} = 0,  0 < x < 1, 0 < y < 1
%   BCs :  T(x=1, y) = T(x, y=1) = 0,
%          (dT*n)_{x, y=0} = 0, (dT*n)_{x=0, y} = 1
%
%   Basis: phi1 = (x2-x)(y2-y)/(x2-x1)/(y2-y1)
%          phi2 = (x-x1)(y2-y)/(x2-x1)/(y2-y1)
%          phi3 = (x2-x)(y-y1)/(x2-x1)/(y2-y1)
%          phi4 = (x-x1)(y-y1)/(x2-x1)/(y2-y1)
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
x1 = xe(1, 1); x2 = xe(1, 4); dx = x2-x1;
y1 = xe(2, 1); y2 = xe(2, 4); dy = y2-y1;

% TODO: Replace with your function from Homework 4 (or the posted solution)
% Stiffness matrix:
% Ke(i, j) = \int_{x_1}^{x_2} \int_{y_1}^{y_2} phi_{i,k} * phi_{j,k} dy dx
Ke = (1/(6*dx*dy))*[2*(dx^2+dy^2), dx^2-2*dy^2, -2*dx^2+dy^2, -dx^2-dy^2; ...
                    dx^2-2*dy^2, 2*(dx^2+dy^2), -dx^2-dy^2, -2*dx^2+dy^2; ...
                    -2*dx^2+dy^2, -dx^2-dy^2, 2*(dx^2+dy^2), dx^2-2*dy^2; ...
                    -dx^2-dy^2, -2*dx^2+dy^2, dx^2-2*dy^2, 2*(dx^2+dy^2)];

% Force vector:
% Fe(i) = \int_{y_1}^{y_2} \phi_i(x=0, y) dy
fe = zeros(4, 1);
if x1<1.0e-14
    fe = 0.5*dy*[1; 0; 1; 0];
end

end