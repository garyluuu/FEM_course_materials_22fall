function [Re, dRe] = intg_elem_claw_vol(Ue, transf_data, elem, elem_data)
%INTG_ELEM_CLAW_VOL Integrate element Galerkin form (volume term) to
%form the volume contribution to the element residual and Jacobian.
%
% Input arguments
% ---------------
%   UE : Array (NDOF_PER_ELEM,) : Element solution (primary variables)
%
%   TRANSF_DATA, ELEM, ELEM_DATA : See notation.m
%
% Output arguments
% ----------------
%   RE : Array (NDOF_PER_ELEM,) : Element residual (volume contribution)
%
%   DRE : Array (NDOF_PER_ELEM, NDOF_PER_ELEM) : Element Jacobian (volume contribution)

% Extract information from input : sizes
[nvar_per_elem, nvar, ndimP1, nq] = size(elem.Tv_ref);
neqn = nvar; ndim = ndimP1-1;

% Extract information from input : quadrature
wq = elem.qrule.wq;

% Extract information from input : isoparametric
detG = transf_data.detG;

% Preallocate element residual and Jacobian
Re = zeros(nvar_per_elem, 1);
dRe = zeros(nvar_per_elem, nvar_per_elem);

% Code me!
Tv_phys = elem_data.Tv_phys;
%% For Re
for k = 1:nq
     
    U = (Tv_phys(:,:,1,k))'*Ue;
    for j = 2:ndimP1
        Q(:,j-1) = (Tv_phys(:,:,j,k))'*Ue;
    end
    
    [S,~,~,F,~,~] = elem.eqn.srcflux(U,Q,elem_data.vol_pars(:,k));
    
    for l = 1:nvar_per_elem
        t1 = 0;
        t2 = 0;
        for i = 1:nvar
            t1 = t1 + (Tv_phys(l,i,1,k)*S(i));
            
            for j = 1:ndim
                t2 = t2 + (Tv_phys(l,i,1+j,k)*F(i,j));
            end
        end
        Re(l) = Re(l) +((-t1 - t2)*wq(k).*detG(k));
    end
end

%% For dRe
for k = 1:nq
    
    U = (Tv_phys(:,:,1,k))'*Ue;
    for j = 2:ndimP1
        Q(:,j-1) = (Tv_phys(:,:,j,k))'*Ue;
    end
        
    [S, dSdU, dSdQ, F, dFdU, dFdQ] = elem.eqn.srcflux(U,Q,elem_data.vol_pars(:,k));
    
    for l = 1:nvar_per_elem
          for r = 1:nvar_per_elem
              
        c1 = 0;
        c2 = 0;
        
        for i = 1:nvar
            t1 = 0;
            t2 = 0;
            for t = 1:nvar
                t1 = t1 + (dSdU(i,t)*Tv_phys(r,t,1,k));
               
                for s = 1:ndim
                    t2 = t2 + (dSdQ(i,t,s)*Tv_phys(r,t,1+s,k));  
                end
            end
            
            c1 = c1 + (Tv_phys(l,i,1,k)) * (t1+t2);
        end
        
        for i = 1:nvar
            
            for j = 1:ndim
                t3 = 0;
                t4 = 0;
                for t = 1:nvar
                    t3 = t3 + (dFdU(i,j,t)*Tv_phys(r,t,1,k));
                    
                    for s = 1:ndim
                        t4 = t4 + (dFdQ(i,j,t,s)*Tv_phys(r,t,1+s,k)); 
                    end
                end
                
                c2 = c2 + (Tv_phys(l,i,1+j,k)) * (t3 + t4);
            end
        end
        
        dRe(l,r) = dRe(l,r) + (-c1 - c2)*wq(k).*detG(k);
        
          end
          
    end
end

end