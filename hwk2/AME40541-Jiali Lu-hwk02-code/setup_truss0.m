function [msh, femsp, fbc_val] = setup_truss0(pltit)
%SETUP_TRUSS0 Setup Truss 0 geometry, material properties, boundary
%conditions.
%
% Input arguments
% ---------------
%   PLTIT : bool : Whether to plot truss structure
%
% Output arguments
% -----------------
%   MSH, FEMSP, FBC_VAL : See notation.m

if nargin<1, pltit = false; end

% DEFINITIONS
% -----------
% NDIM : Number of spatial dimensions
% NNODE : Number of nodes in mesh
% NELEM : Number of elements in mesh
% NDOF_PER_ELEM : Number of degrees of freedom per element
% NNODE_PER_ELEM : Number of nodes per element
% NDOF : Number of global degrees of freedom
% NDBC : Number of global degrees of freedom containing an essential BC

% XCG : Array (NDIM, NNODE) : The position of the nodes in the mesh.
%   The (i, j)-entry is the position of node j in the ith dimension. The
%   global node numbers are defined by the columns of this matrix, e.g.,
%   the node at XCG(:, j) is the jth node of the mesh.
xcg = [0.0, 1.0, 0.0, 1.0,1.5; ...
       0.0, 0.0, 1.0, 1.0,1.0];
   
% E2VCG : Array (NNODE_PER_ELEM, NELEM): The connectivity of the
%   mesh. The (:, e)-entries are the global node numbers of the nodes
%   that comprise element e. The local node numbers of each element are
%   defined by the columns of this matrix, e.g., E2VCG(i, e) is the
%   global node number of the ith local node of element e.
e2vcg = [1, 1, 2, 3, 2,1,4,2; ...
         2, 3, 4, 4, 3,4,5,5];
     
% EA : Array (NELEM,) : Young's modulus times cross-sectional area for
%   each element.
EA = [1.0; 2.0; 3.0; 4.0; 5.0;6.0;7.0;8.0];

% DBC_IDX : Array (NDBC,) : Indices into array defined over global dofs
%   (size = NDIM*NNODE) that indicates those with prescribed
%   primary variables (essential BCs).
dbc_idx = [1; 2; 4];

% DBC_VAL : Array (NDBC,) : Value of the prescribed primary variables such
%   that U(DBC_IDX) = DBC_VAL, where U is a (NDIM*NNODE,) vector
%   that contains the primary variable (all dofs of all nodes).
dbc_val = [0.0; 0.0; 0.0];

% FBC_VAL : Array (NDOF-NDBC,) : Value of the prescribed forces at all
%   global dofs without a prescribed displacement (NFBC = NDIM*NNODE-NDBC).
%   Let FBC_IDX = setdiff(1:NDIM*NNODE, DBC_IDX), then F(FBC_IDX) = FBC_VAL
fbc_val = [0.0; 0.0; 0.0; 0.0; 0.0;0.0;-0.5];

% Create mesh and finite element space
msh = create_mesh_strct_truss(xcg, e2vcg);
femsp = create_femsp_truss(msh, EA, dbc_idx, dbc_val);

% Plot truss
if pltit
    [ndim, nnode] = size(xcg);
    f = zeros(ndim*nnode, 1);
    fbc_idx = setdiff(1:ndim*nnode, dbc_idx);
    f(fbc_idx) = fbc_val;
    visualize_truss([], msh, [], EA, 1, dbc_idx, f);
end

end