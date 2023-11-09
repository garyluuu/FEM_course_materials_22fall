function [Ke] = intg_elem_stiff_truss(transf_data, EA)
%INTG_ELEM_STIFF_TRUSS Evaluate the stiffness matrix for a truss element
%
% Input arguments
% ---------------
%   TRANSF_DATA, EA : See notation.m
%
% Output arguments
% -----------------
%   KE : Array (NDOF_PER_ELEM, NDOF_PER_ELEM) : Element stiffness matrix

% Extract EA/L and cosine, sine of angle bar makes with horizontal
L = transf_data.L;
Q = transf_data.Q;

% TODO: Finish me!
blank=zeros(2,2);
Ke=EA/L*[Q,blank;blank,Q]'*[1,0,-1,0;0,0,0,0;-1,0,1,0;0,0,0,0]*[Q,blank;blank,Q];
end