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
syms x

x1 = xe(1, 1); x2 = xe(1, 4); dx = x2-x1;
y1 = xe(2, 1); y2 = xe(2, 4); dy = y2-y1;

phi(1) = (x2-x)(y2-y)/(x2-x1)/(y2-y1);
phi(2) = (x-x1)(y2-y)/(x2-x1)/(y2-y1);
phi(3) = (x2-x)(y-y1)/(x2-x1)/(y2-y1);
phi(4) = (x-x1)(y-y1)/(x2-x1)/(y2-y1);
% TODO: Finish me!
for i=1:4
    for j=1:4
        Ke(i,j)=int(diff(phi(i))*diff(phi(j))-phi(i)*phi(j),x,x1,x2,y,y1,y2);
    end
end

%if including boundary
if x1==0 & x2==0
    for i=1:4
        fe(i)=int(eval(phi(i),x,0),y,y1,y2);
    end
%if not including boundary
else
    for i=1:4
        fe(i)=0;
    end
end
%if not including boundary
end