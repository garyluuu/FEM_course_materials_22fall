% Create finite element mesh
nelem = [3, 3];
msh = create_mesh_hcube([0, 1; 0, 1], nelem);
visualize_fem([], msh, true, true);

% Create finite element space (with DBCs)
xcg = msh.xcg;
dbc_idx = find(xcg(1, :)'>1.0-1.0e-14 | xcg(2, :)'>1.0-1.0e-14);
dbc_val = zeros(size(dbc_idx));
femsp = create_femsp_cg(msh, dbc_idx, dbc_val);

% Solve FEM
u = solve_fem_dense(msh, femsp, @intg_elem_stiff_load_pde1);

% Visualize FE and exact solution
visualize_fem(u, msh, false, false);