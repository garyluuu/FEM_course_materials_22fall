function [K] = assemble_nobc_mat_dense(Ke, ldof2gdof)
%ASSEMBLE_NOBC_MAT Assemble element matrices into a global matrix without
%applying Dirichlet/essential boundary conditions.
%
%Input arguments
%---------------
%  ME : Array (NDOF_PER_ELEM, NDOF_PER_ELEM, NELEM): Element matrix for
%    all elements in mesh
%
%  LDOF2GDOF : See notation.m
%
%Output arguments
%----------------
%   M : Array (NDOF, NDOF) : Assembled matrix PRIOR to static condensation

% Extract quantities
N = max(ldof2gdof(:));
nelem = size(Ke, 3);
ndof_per_node=2;
nnode_per_elem=2;

% Preallocate M
K = zeros(N, N);

% TODO: Finish me!
for i=1:N
    for s=1:N
        for e=1:nelem
            for j=1:ndof_per_node*nnode_per_elem
                for k=1:ndof_per_node*nnode_per_elem
                    if(s==ldof2gdof(k,e) && i==ldof2gdof(j,e))
                        K(i,s)=K(i,s)+Ke(j,k,e);
                    end
                end
            end
        end
    end
end
end