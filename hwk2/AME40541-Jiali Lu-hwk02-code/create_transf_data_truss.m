function [transf_data] = create_transf_data_truss(xcg, e2vcg)
%CREATE_TRANSF_DATA_TRUSS Create transformation data to element coordinates
%system for each element of the truss structure.
%
% Input arguments
% ---------------
%   XCG, E2VCG : See notation.m
%
% Output arguments
% -----------------
%   TRANSF_DATA : See notation.m

% Extract information from input
ndim = size(xcg, 1);
nelem = size(e2vcg, 2);

% Compute the length of elements and sin/cos
% of angles w.r.t. horizontal
L = zeros(nelem, 1);
Q = zeros(ndim, ndim, nelem);
for e=1:nelem
   L(e)=sqrt((xcg(1,e2vcg(1,e))-xcg(1,e2vcg(2,e)))^2+(xcg(2,e2vcg(1,e))-xcg(2,e2vcg(2,e)))^2);
   theta=atan((xcg(2,e2vcg(2,e))-xcg(2,e2vcg(1,e)))/(xcg(1,e2vcg(2,e))-xcg(1,e2vcg(1,e))));
   Q(:,:,e)=[cos(theta),sin(theta);-sin(theta),cos(theta)];
end
% TODO: Finish me!

% Create elem_data structure array from numeric arrays
transf_data = struct('L', squeeze(num2cell(L))', ...
                     'Q', squeeze(num2cell(Q, [1, 2]))');
               
end