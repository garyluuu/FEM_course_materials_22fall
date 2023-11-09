outdir = './'; % Change me to folder you want plots save
% outdir = '../img/';

%% Truss 0
[msh, femsp, fbc_val] = setup_truss0(false);
[U, F] = solve_dsm_truss(msh, femsp, fbc_val);
disp('u0 = '); disp(reshape(U, [2, numel(U)/2]));
disp('f0 = '); disp(reshape(F, [2, numel(F)/2]));
visualize_truss([], msh, U, femsp.EA, 1, femsp.dbc.dbc_idx, F);
print(gcf, '-depsc2', [outdir, 'truss0']);

%% Truss 1
[msh, femsp, fbc_val, ebc_idx, ebc_val] = setup_truss1(false);
[U, F] = solve_dsm_truss_ebcs(msh, femsp, fbc_val, ebc_idx, ebc_val);
disp('u1 = '); disp(reshape(U, [2, numel(U)/2]));
disp('f1 = '); disp(reshape(F, [2, numel(F)/2]));
visualize_truss([], msh, U, femsp.EA, 1, femsp.dbc.dbc_idx, F);
print(gcf, '-depsc2', [outdir, 'truss1']);

%% Truss 2
[msh, femsp, fbc_val] = setup_truss2(false);
[U, F] = solve_dsm_truss(msh, femsp, fbc_val);
disp('u2 = '); disp(reshape(U, [2, numel(U)/2]));
disp('f2 = '); disp(reshape(F, [2, numel(F)/2]));
visualize_truss([], msh, U, femsp.EA, 1, femsp.dbc.dbc_idx, F);
print(gcf, '-depsc2', [outdir, 'truss2']);

%% Warren truss
[msh, femsp, fbc_val] = setup_warren_truss(8, false);
[U, F] = solve_dsm_truss(msh, femsp, fbc_val);
disp('uw = '); disp(reshape(U, [2, numel(U)/2]));
disp('fw = '); disp(reshape(F, [2, numel(F)/2]));
visualize_truss([], msh, U, femsp.EA, 1, femsp.dbc.dbc_idx, F);
print(gcf, '-depsc2', [outdir, 'warren']);