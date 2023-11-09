function [u, f] = solve_dsm_truss(msh, femsp, fbc_val,K,u)
%SOLVE_DSM_TRUSS Solve for the nodal displacements and reaction forces of a
%truss structure.
%
% Input arguments
% ---------------
%   MSH, FEMSP, FBC_VAL : See notation.m
%
% Output arguments
% -----------------
%   U, F : See notation.m

ndof = size(K, 1);

fbc_idx = setdiff(1:ndof, femsp.dbc.dbc_idx);

Kuu=zeros(length(fbc_idx));
Kuc=zeros(length(fbc_idx),length(femsp.dbc.dbc_idx));
Kcu=zeros(length(femsp.dbc.dbc_idx),length(fbc_idx));
Kcc=zeros(length(femsp.dbc.dbc_idx),length(femsp.dbc.dbc_idx));
% TODO: Finish me!
for i=1:length(fbc_idx)
    for j=1:length(fbc_idx)
        Kuu(i,j)=K(fbc_idx(i),fbc_idx(j));
    end
end
for i=1:length(fbc_idx)
    for j=1:length(femsp.dbc.dbc_idx)
        Kuc(i,j)=K(fbc_idx(i),femsp.dbc.dbc_idx(j));
    end
end
for i=1:length(femsp.dbc.dbc_idx)
    for j=1:length(fbc_idx)
        Kcu(i,j)=K(femsp.dbc.dbc_idx(i),fbc_idx(j));
    end
end
for i=1:length(femsp.dbc.dbc_idx)
    for j=1:length(femsp.dbc.dbc_idx)
        Kcc(i,j)=K(femsp.dbc.dbc_idx(i),femsp.dbc.dbc_idx(j));
    end
end

uu=u(1:length(fbc_idx));
uc=u(length(fbc_idx)+1:ndof);

fu=fbc_val;
fc=zeros(length(femsp.dbc.dbc_idx),1);

uu=inv(Kuu)*(fu-Kuc*uc);
fc=Kcu*uu+Kcc*uc;

for i=1:length(fbc_idx)
    u(fbc_idx(i))=uu(i);
end
for i=1:length(femsp.dbc.dbc_idx)
    u(femsp.dbc.dbc_idx(i))=uc(i);
end

for i=1:length(fbc_idx)
    f(fbc_idx(i))=fu(i);
end
for i=1:length(femsp.dbc.dbc_idx)
    f(femsp.dbc.dbc_idx(i))=fc(i);
end
end