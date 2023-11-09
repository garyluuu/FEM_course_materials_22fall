function [ZK, F2V, N] = create_nodes_bndy_refdom_simp(ndim, porder)
%CREATE_NODES_BNDY_REFDOM_SIMP Create nodal distribution and boundary of
%NDIM-dimensional simplex element of order PORDER.
%
%Input arguments
%---------------
%   NDIM, PORDER : See notation.m
%
%Output arguments
%----------------
%   ZK, F2V, N : See notation.m

% Treat 0-dimensional case (boundary of 1D element) as special case
if ndim == 0
    ZK = zeros(0, 1); F2V = []; N = [];
    return;
end

% Extract information from input
p=porder;
nf = ndim+1;
nvf = p+1;
if ndim == 1
    nv = p+1;
elseif ndim == 2
    nv = (p+1)*(p+2)/2;
end

% Code me!
%initialize N,F2V,ZK
N = zeros (ndim, nf);
F2V = zeros (nvf, nf);
ZK = zeros (ndim, nv);

%d=1
if ndim==1
    N=[0;1];
    F2V=1:1:nvf;
    ZK(1,:)=0:1/p:1;
    %ZK(2,:)=all zeros
elseif ndim==2
    hold on
    N=[-1,0,1/sqrt(2);0,-1,1/sqrt(2)];
    nnum=1;%node number
    for i=1:nvf
        F2V(i,1)=nnum;
        for j=1:nvf+1-i
            ZK(1,nnum)=(j-1)/p;
            ZK(2,nnum)=(i-1)/p;
            plot(ZK(1,nnum),ZK(2,nnum),'bo')
            if i==1
                F2V(j,2)=nnum;
            end
            if j==nvf+1-i
                F2V(i,3)=nnum;
            end
            nnum=nnum+1;
        end
    end
    %plot special nodes
    for i=1:nf
        for j=1:nvf
            if i==1
                plot(ZK(1,F2V(j,i)),ZK(2,F2V(j,i)),'rx')
            elseif i==2
                plot(ZK(1,F2V(j,i)),ZK(2,F2V(j,i)),'gs')
            elseif i==3
                plot(ZK(1,F2V(j,i)),ZK(2,F2V(j,i)),'k+')
            end
        end
    end        
end
end