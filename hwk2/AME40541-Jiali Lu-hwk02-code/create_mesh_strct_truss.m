function [msh] = create_mesh_strct_truss(xcg, e2vcg)
%CREATE_MESH_STRUCT_TRUSS Create mesh structure from nodes and connectivity
%
% Input arguments
% ---------------
%   XCG, E2VCG : See notation.m
%
% Output arguments
% ----------------
%   MSH : See notation.m

transf_data = create_transf_data_truss(xcg, e2vcg);
msh = struct('xcg', xcg, 'e2vcg', e2vcg, ...
             'transf_data', transf_data);

end