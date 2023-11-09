function [Re] = intg_elem_claw_extface(transf_data, elem, elem_data)
%INTG_ELEM_CLAW_EXTFACE Integrate element Galerkin form (boundary term) to
%form the boundary contribution to the element residual and Jacobian.
%
% Input arguments
% ---------------
%   TRANSF_DATA, ELEM, ELEM_DATA : See notation.m
%
% Output arguments
% ----------------
%   RE : Array (NDOF_PER_ELEM,) : Element residual (boundary contribution)

% Extract information from input : sizes
[nvar_per_elem, ~, ~, nqf, nf] = size(elem.Tvf_ref);
e2bnd = transf_data.e2bnd;

% Extract information from input : quadrature
wqf = elem.qrule.wqf;

% Extract information from input : isoparametric
sigf = transf_data.sigf;

% Preallocate element residual and Jacobian
Re = zeros(nvar_per_elem, 1);

% Set up more variables (For ease)

n = elem_data.bnd_pars;
[ndim, ~, ~] = size(n);

Tvf_phys = elem_data.Tvf_phys;
[~, nvar, ~, ~] = size(Tvf_phys);

%% For Re
for k = 1:nqf
    
    for l = 1:nvar_per_elem
        t2 = 0;
       
        for f = 1:nf
            t1 = 0;
            
            if isnan(e2bnd(f))
                continue
            end
            
            for i = 1:nvar
                               
               for j = 1:ndim
                
                t1 = t1 + (Tvf_phys(l,i,1,k)*n(j,k,f)*sigf(f)*wqf(k));
               end
            end
            t2 = t2 + t1;
        end
        
       Re(l) = Re(l) + t2;
        
    end
end

end