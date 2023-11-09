function [U, info] = solve_linelptc_sclr_batman0(nref, porder, pltit)
%SOLVE_LINELPTC_SCLR_BATMAN0 Solve Poisson equation on Batman mesh using
%FEM with simplex elements of polynomial completeness PORDER, see project
%handout for complete problem description.
%
% Input arguments
% ---------------
%   NREF : number : level of refinement (only 0 supported for now)
%
%   PORDER : See notation.m
%
%   PLTIT : bool : Whether to plot solution
%
% Output arguments
% ----------------
%   U : Array (NDOF,) : Global (assembled) finite element solution
%
%   INFO : See NEWTRAPH

nvar = 1;
ndim = 2;

% Load finite element mesh
msh = load_mesh('batman0', 'simp', nref, porder);
xcg = msh.xcg; e2vcg = msh.e2vcg; e2bnd = msh.e2bnd;

% Setup equation parameters and natural boundary conditions
prob.eqn = LinearEllipticScalar(ndim);
prob.vol_pars_fcn = @(x) [1; 0; 0; 10; 0];
prob.bnd_pars_fcn = @(x, bnd) -10*sin(x(1))*(bnd==1) -10*sin(x(1))*(bnd==2) + 0*(bnd==3);

% Extract indices and set values of dirichlet boundary conditions
dbc_idx = get_node_from_bndtag(3, e2vcg, msh.e2bnd, msh.lfcnsp.f2v);
dbc_val =0*dbc_idx;

ndof = size(xcg, 2);
dbc = create_dbc_strct(ndof, dbc_idx, dbc_val);

% Create finite element space
femsp = create_femsp_cg(prob, msh, porder, e2vcg, dbc);

% Solve finite element equations
tol = 1.0e-8; maxit = 10;
[U, info] = solve_fem(femsp, [], tol, maxit);

% Visualize FEM solution
if pltit
    % Evaluate FEM solution throughout domain
    xeval = [linspace(0.3,0.7,50);
             (-0.2*ones(1,50))];
    Ux = eval_fem_soln(U(femsp.ldof2gdof), xeval, msh, femsp.elem);

    visualize_fem([], msh, U(e2vcg), struct('plot_elem', true));
    colorbar;

    figure;
    plot(xeval(1, :), squeeze(Ux(1, 1, :)), 'k-', 'linewidth', 2);
end

end