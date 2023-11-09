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
% NNODE_PER_ELEM : Number of degrees of freedom per node (=NDIM for truss)
%
% NDOF : Number of global degrees of freedom
%
% NDBC : Number of global degrees of freedom containing an essential BC
%
% NEBC : Number of global degrees of freedom containing an elastic BC


% MESH
% ----
% MSH : Structure containing XCG, E2VCG, TRANSF_DATA
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
% FEMSP : Structure containing EA, LDOF2GDOF, DBC
%
% EA : Array (NELEM,) : Young's modulus times cross-sectional area for
%   each element.
%
% LDOF2GDOF : Array (NDOF_PER_ELEM, NELEM) : Maps
%   local degrees of freedom for each element to global degrees of
%   freedom, ignoring boundary conditions. LDOF2GDOF(i, e) is the global
%   degree of freedom corresponding to the ith local degree of freedom
%   of element e.

% TRANSFORMATION DATA STRUCTURE
% -----------------------------
% TRANSF_DATA: Array of struct (NELEM,) : Transformation information to
%    element coordinate system. Fields: L, Q
%
% L : Array (NELEM,) : L(e) is the length of element e.
%
% Q : Array (NDIM, NDIM, NELEM) : Q(:, :, e) is the clockwise rotation
%    matrix that rotations element e onto the (1,0) direction. 

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
%
% FBC_VAL : Array (NDOF-NDBC,) : Value of the prescribed forces at all
%   global dofs without a prescribed displacement (NFBC = NDIM*NNODE-NDBC).
%   Let FBC_IDX = setdiff(1:NDIM*NNODE, DBC_IDX), then F(FBC_IDX) = FBC_VAL
%   (see definition of F below).
%
% EBC_IDX : Array (NEBC,) : Indices into array defined over global dofs
%   (size = NDOF_PER_NODE*NNODE) that indicates those with elastic BCs.
%
% EBC_VAL : Array (NEBC,) : Value of the spring constant at elastic BCs.

% GLOBAL (ASSEMBLED) SOLUTION
% ---------------------------
%   U : Array (NDOF,) : Global (assembled) solution vector containing
%     all degrees of freedom in the finite element mesh (before static
%     condensation). More specifically, the displacement of each node in
%     the truss with components U = [Ux_1; Uy_1; ... ; Ux_nnode; Uy_nnode],
%     where Ux_i, Uy_i are the x- and y- displacements at node i.
%
%   F : Array (NDOF,) : Global (assembled) force (including reaction force)
%     acting at each global degree of freedom. More specifically, the force
%     acting on each node of the truss with components
%     F = [Fx_1; Fy_1; ... ; Fx_nnode; Fy_nnode], where Fx_i,
%     Fy_i are the x- and y-forces at node i.

% NOTE ABOUT ORDERING OF 1D ARRAYS:
% The ordering of one-dimensional vectors over all/some of the
% degrees of freedom will ALWAYS be ordered first by the dofs at a fixed
% node and then across all nodes (same as the course notes). For example,
% let U be the vector of size NDIM*NNODE containing the degrees of freedom
% at all nodes, then its components are
% U = [Ux_1; Uy_1; ... ; Ux_nnode; Uy_nnode], where Ux_i,
% Uy_i are the x- and y- degrees of freedom at node i.