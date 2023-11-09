%% Object 1 Test
etype = 'simp';
porder = 2;
nquad_per_dim=4;
ndim = 2;

xcg = [0,0.5, 1.0, -0.3 0.3,-0.25;
       0,0.15,0.7,0.5,0.75,1.2];
   
   e2vcg = [1;2;3;4;5;6];
   e2bnd = [1;2;3];
   
   [qrule] = create_qrule_gaussleg(etype,ndim,nquad_per_dim);
   
   [lfcnsp] = create_polysp_nodal(etype,ndim,porder,qrule.zq,qrule.rq);
   
   [transf_data] = create_transf_data_ndim(lfcnsp,xcg,e2vcg,e2bnd);
   
   [v, c, sa] = compute_domain_metrics(transf_data, qrule)



%% Object 2 Test

etype = 'hcube';
porder = 2;
nquad_per_dim=6;
ndim = 2;

xcg = [0,0.6, 1.2, 0.2, 0.8 1.6,0.0,0.6,1.2;
       0,0.4,0.2,0.8,1.0,1.0,1.6,1.4,1.8];
   
   e2vcg = [1;2;3;4;5;6;7;8;9];
   e2bnd = [1;2;3;4];
   
   [qrule] = create_qrule_gaussleg(etype,ndim,nquad_per_dim);
   
   [lfcnsp] = create_polysp_nodal(etype,ndim,porder,qrule.zq,qrule.rq);
   
   [transf_data] = create_transf_data_ndim(lfcnsp,xcg,e2vcg,e2bnd);
   
   [v, c, sa] = compute_domain_metrics(transf_data, qrule)
   
   
%% 1.4.2

etype = 'hcube';
porder = 2;
nel = [10,10];
lims = [0,1;
        0,1]

    msh = create_mesh_hcube(etype, lims, nel, porder) 
   
   [qrule] = create_qrule_gaussleg(etype,ndim,nquad_per_dim);
   
   [lfcnsp] = create_polysp_nodal(etype,ndim,porder,qrule.zq,qrule.rq);
   
   [transf_data] = create_transf_data_ndim(lfcnsp,msh.xcg,msh.e2vcg,msh.e2bnd);
   
   [v, c, sa] = compute_domain_metrics(transf_data, qrule)
   
   [ax] = visualize_fem([], msh)

   % [ax] = visualize_fem([], msh, [], struct('plot_nodes',true))
   
   
%% 1.4.2 - Square

etype = 'hcube';
porder = 2;
nel = [4,4];
lims = [0,2;
        0,1]

    msh = create_mesh_hcube(etype, lims, nel, porder) 
   
   [qrule] = create_qrule_gaussleg(etype,ndim,nquad_per_dim);
   
   [lfcnsp] = create_polysp_nodal(etype,ndim,porder,qrule.zq,qrule.rq);
   
   [transf_data] = create_transf_data_ndim(lfcnsp,msh.xcg,msh.e2vcg,msh.e2bnd);
   
   [v, c, sa] = compute_domain_metrics(transf_data, qrule)
   
   visualize_fem([], msh)
   
%% 1.4.3 - Circle

etype = 'hcube';
porder = 3;
nel = [4,4];
c = [0,0]
r = 1;

    msh = create_mesh_hsphere(etype, c, r, nel, porder)
   
   [qrule] = create_qrule_gaussleg(etype,ndim,nquad_per_dim);
   
   [lfcnsp] = create_polysp_nodal(etype,ndim,porder,qrule.zq,qrule.rq);
   
   [transf_data] = create_transf_data_ndim(lfcnsp,msh.xcg,msh.e2vcg,msh.e2bnd);
   
   [v, c, sa] = compute_domain_metrics(transf_data, qrule)
   
   visualize_fem([], msh)

%% 1.4.4 - Batman

etype = 'simp';
nref = 0;
porder = 3;

    [msh] = load_mesh('batman0', etype, nref, porder)
   
   [qrule] = create_qrule_gaussleg(etype,ndim,nquad_per_dim);
   
   [lfcnsp] = create_polysp_nodal(etype,ndim,porder,qrule.zq,qrule.rq);
   
   [transf_data] = create_transf_data_ndim(lfcnsp,msh.xcg,msh.e2vcg,msh.e2bnd);
   
   [v, c, sa] = compute_domain_metrics(transf_data, qrule)
   
   visualize_fem([], msh)
   
   