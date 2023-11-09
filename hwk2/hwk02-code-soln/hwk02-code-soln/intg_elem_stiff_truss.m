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

% Define the expanded clockwise rotation matrix
T = [Q, zeros(2, 2); zeros(2, 2), Q];

% Compute the element stiffness matrix (for speed, compute T'*ke*T by hand
% and hardcode)
ke = [1, 0, -1, 0; zeros(1, 4); -1, 0, 1, 0; zeros(1, 4)];
Ke = (EA/L)*(T'*ke*T);

end