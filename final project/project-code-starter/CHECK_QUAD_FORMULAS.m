% create qrule

qrule = create_qrule_gaussleg('simp',2,6);

lfcnsp = create_polysp_nodal('simp',2,2,qrule.zq,qrule.rq);

zk = [0 0.5 1 -0.3 0.3 -0.25; 0 0.15 0.7 0.5 0.75 1.2];

[xq, detG, Gi, xqf, sigf, Gif] = eval_transf_quant_ndim(zk,lfcnsp.Qv,lfcnsp.Qvf,lfcnsp.r2z,lfcnsp.f2v);

ndim = 2;


v = 0;
c = zeros(ndim, 1);
[nq, dont_care] = size(qrule.wq);
[nqf, also_dont_care] = size(qrule.wqf);

for k = 1:nq
    v = v + (qrule.wq(k)*detG(k));
    c = c + (qrule.wq(k) * xq(:,k) * detG(k));  
end

c = c./v;

v
c

sa = 0;

for k = 1:nqf
    for i = 1:3
   sa = sa + (qrule.wqf(k)*sigf(k,i));
    end
end

sa


