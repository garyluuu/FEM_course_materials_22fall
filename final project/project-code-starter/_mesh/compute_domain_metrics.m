function [v, c, sa] = compute_domain_metrics(transf_data, qrule)
%COMPUTE_DOMAIN_METRICS Compute the volume, centroid, and surface
%area of a domain (approximated) by the mesh described by TRANSF_DATA.
%
%Input arguments
%---------------
%  TRANSF_DATA, QRULE : See notation.m
%
%Output arguments
%----------------
%  V : number : Volume of domain
%
%  C : Array (NDIM,) : Centroid of domain
%
%  SA : number : Surface area of domain

% Extract relevant quantities
ndim = size(transf_data(1).xe, 1);
nf = size(transf_data(1).sigf, 2);
nelem = numel(transf_data);

% Initialize volume, centroid, surface area
c = zeros(ndim, 1);
v = 0.0; sa = 0.0;

% Code me!
nq = size(qrule.wq,1);
nqf = size(qrule.wqf,1);

for e=1:nelem
    for k = 1:nq
        v = v + (qrule.wq(k)*transf_data(e).detG(k));
        c = c + (qrule.wq(k) * transf_data(e).xq(:,k) * transf_data(e).detG(k));
    end
     
    for f = 1:nf
       if isnan(transf_data(e).e2bnd(f))
           continue
       end
        for k = 1:nqf
            sa = sa + (qrule.wqf(k)*transf_data(e).sigf(k,f));
        end
    end
end

c = c./v;

end
