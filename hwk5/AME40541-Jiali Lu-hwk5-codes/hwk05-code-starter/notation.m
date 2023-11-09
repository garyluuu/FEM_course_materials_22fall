% DEFINITIONS
% -----------
% NDIM : Number of spatial dimensions
%
% NNODE : Number of nodes in mesh
%
% NELEM : Number of elements in mesh
%
% NDOF_PER_ELEM : Number of degrees of freedom per element
%
% NNODE_PER_ELEM : Number of nodes per element
%
% NDOF_PER_ELEM : Number of degrees of freedom per node (=NNODE_PER_ELEM for PDE0,1)
%
% NDOF : Number of global degrees of freedom
%
% NDBC : Number of global degrees of freedom containing an essential BC

% MESH
% ----
% MSH : Structure containing XCG, E2VCG
%
% XCG : Array (NDIM, NNODE) : The position of the nodes in the mesh.
%   The (i, j)-entry is the position of node j in the ith dimension. The
%   global node numbers are defined by the columns of this matrix, e.g.,
%   the node at XCG(:, j) is the jth node of the mesh.
%
% E2VCG : Array (NNODE_PER_ELEM, NELEM): The connectivity of the
%   mesh. The (:, e)-entries are the global node numbers of the nodes
%   that comprise element e. The local node numbers of each element are
%   defined by the columns of this matrix, e.g., E2VCG(i, e) is the
%   global node number of the ith local node of element e.

% FINITE ELEMENT SPACE
% --------------------
% FEMSP : Structure containing LDOF2GDOF, DBC
%
% LDOF2GDOF : Array (NDOF_PER_ELEM, NELEM) : Maps
%   local degrees of freedom for each element to global degrees of
%   freedom, ignoring boundary conditions. LDOF2GDOF(i, e) is the global
%   degree of freedom corresponding to the ith local degree of freedom
%   of element e.

% BOUNDARY CONDITIONS
% -------------------
% DBC : Structure containing DBC_IDX, FREE_IDX, DBC_VAL
%
% DBC_IDX : Array (NDBC,) : Indices into array defined over global dofs
%   (size = NDOF_PER_NODE*NNODE) that indicates those with prescribed
%   primary variables (essential BCs).
%
% DBC_VAL : Array (NDBC,) : Value of the prescribed primary variables such
%   that U(DBC_IDX) = DBC_VAL, where U is a (NDOF_PER_NODE*NNODE,) vector
%   that contains the primary variable (all dofs of all nodes).

% GLOBAL (ASSEMBLED) SOLUTION
% ---------------------------
%   U : Array (NDOF,) : Global (assembled) solution vector containing
%     all degrees of freedom in the finite element mesh (before static
%     condensation).