function [msh] = create_mesh_hcube(lims, nel)
%CREATE_MESH_HCUBE Create a mesh of a hypercube in NDIM-dimensions
%using hypercube elements.
%
%Input arguments
%---------------
%   LIMS : Array (NDIM, 2) : Extents of domain in each direction
%
%   NEL : Array (NDIM,) : Number of elements in mesh in each direction
%
%Output arguments
%----------------
%   MSH : See notation.m

% Extract information from input
porder = 1;
nel = nel(:)';
ndim = numel(nel);
nelem = prod(nel);

% Create nodes (XCG) via a tensor product
v = cell(1, ndim);
for k=1:ndim
    v{k} = linspace(lims(k, 1), lims(k, 2), nel(k)*porder+1);
end
xcg = tensprod_vector_from_onedim(v);

% Create ndim array of all node numbers and indices into it that will help
% extract node numbers for each element
if ndim == 1
    M = 1:nel*porder+1;
else
    M = reshape(1:prod(nel*porder+1), [nel*porder+1]);
end
idx_start = cell(1, ndim);
idx_offset = cell(1, ndim);
for k = 1:ndim
    idx_start{k} = 1:porder:nel(k)*porder;
    idx_offset{k} = 1:porder+1;
end
strt = M(idx_start{:}); strt = strt(:);
off = M(idx_offset{:}); off = off(:)-1;

% Create connectivity matrix
e2vcg = zeros((porder+1)^ndim, nelem);
for e=1:nelem
    e2vcg(:, e) = strt(e) + off;
end

% Return msh structure
msh = struct('xcg', xcg, 'e2vcg', e2vcg);

end

function [v] = tensprod_vector_from_onedim(vk)

N = numel(vk);
out = cell(1, N);
[out{:}] = ndgrid(vk{:});
out = cellfun(@(M) M(:), out, 'UniformOutput', false);

v = [out{:}]';

end