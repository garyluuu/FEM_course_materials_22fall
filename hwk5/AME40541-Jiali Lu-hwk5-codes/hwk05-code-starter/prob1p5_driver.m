% Create finite element mesh
nelem = 3;
msh = create_mesh_hcube([0, 1], nelem);
visualize_fem([], msh, true, true);

% Create finite element space (with DBCs)
dbc_idx = 1;
dbc_val = 0.0;
femsp = create_femsp_cg(msh, dbc_idx, dbc_val);

% Solve FEM
u = solve_fem_dense(msh, femsp, @intg_elem_stiff_load_pde0);

% Visualize FE and exact solution
visualize_fem(u, msh, false, false);
hold on;
x = linspace(0.0, 1.0, 1000);
plot(x, (1.0/cos(1))*(2*cos(1-x)-sin(x)) + x.^2 - 2, 'r--', 'linew', 2);