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
syms x

x1 = xe(1, 1);
x2 = xe(1, 2);
he = x2-x1;

phi1 = (x2-x)/(x2-x1);
phi2 = (x-x1)/(x2-x1);

% TODO: Finish me!
Ke(1,1)=int(diff(phi1)*diff(phi1)-phi1*phi1,x,x1,x2);
Ke(1,2)=int(diff(phi1)*diff(phi2)-phi1*phi2,x,x1,x2);
Ke(2,1)=int(diff(phi2)*diff(phi1)-phi2*phi1,x,x1,x2);
Ke(2,2)=int(diff(phi2)*diff(phi2)-phi2*phi2,x,x1,x2);

%if including boundary
if x2==1
    fe(1)=int(-phi1*x^2,x,x1,x2)+phi1(1);
    fe(2)=int(-phi2*x^2,x,x1,x2)+phi2(1);
%if not including boundary
else
    fe(1)=int(-phi1*x^2,x,x1,x2);
    fe(2)=int(-phi2*x^2,x,x1,x2);
end