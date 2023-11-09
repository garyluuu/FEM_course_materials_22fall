function  [] = visualize_truss(ax, msh, u, EA, scale, dbc_idx, F)
%VISUALIZE_TRUSS Plot truss - undeformed truss (black), deformed truss
%(blue), and displacement and force boundary conditions (optional).
%
%Input arguments
%---------------
%   AX : Axis handle in which to plot (use [] to create new plot)
%
%   MSH, U, EA, DBC_IDX, F : See definition in notation.m
%
%   SCALE : Factor by which to scale displacements

% Extract information from input
xcg = msh.xcg;
e2vcg = msh.e2vcg;
ndim = size(xcg, 1);
nnode = size(xcg, 2);
nelem = size(e2vcg, 2);

% Default values
if nargin < 3 || isempty(u), u = zeros(ndim*nnode, 1); end
if nargin < 4 || isempty(EA), EA = ones(nelem, 1); end
if nargin < 5 || isempty(scale), scale = 1; end
if nargin < 6, dbc_idx = []; end
if nargin < 7, F = []; end

% Compute displaced nodes
u = reshape(u, [ndim, nnode]);
x = xcg + scale*u;

% Plot reference and displaced nodes
if isempty(ax), figure; ax = axes; end
plot(xcg(1, :), xcg(2, :), 'ks'); hold on;
plot(x(1, :), x(2, :),'bs');

% Plot reference and displaced elements
for e = 1:nelem
    n1 = e2vcg(1, e);
    n2 = e2vcg(2, e);
    h(1) = plot(xcg(1, [n1; n2]), xcg(2, [n1; n2]), 'k-');
    h(2) = plot(x(1, [n1; n2]), x(2, [n1; n2]), 'b--');
    set(h, 'linewidth', 2*EA(e)/max(EA));
end
axis equal;

% Limits
xmin = min([x(1, :), xcg(1, :)], [], 2); ymin = min([x(2, :), xcg(2, :)], [], 2);
xmax = max([x(1, :), xcg(1, :)], [], 2); ymax = max([x(2, :), xcg(2, :)], [], 2);
dx = xmax-xmin; dy = ymax-ymin;
max_del = max([dx, dy]);

if ~isempty(dbc_idx)
    % Plot Dirichlet boundary conditions
    l = 0.01*max_del;
    ubc = false(ndim*nnode, 1); ubc(dbc_idx) = true;
    ubc = reshape(ubc, ndim, nnode);
    for i = 1:nnode
        if ubc(1, i) && ubc(2, i) % Pin
            plot_triangle_below(gca, xcg(:, i), 2*l);
        elseif ubc(1, i) % Left roller
            plot_circle_at(gca, xcg(:, i)-[l; 0], l);
        elseif ubc(2, i)
            plot_circle_at(gca, xcg(:, i)-[0; l], l);
        end
    end
end

if ~isempty(F)
    % Plots external forces
    Fp = reshape(F, ndim, nnode);
    Fp = (0.1*max_del)*Fp/max(sqrt(sum(Fp.^2, 1)));
    for i = 1:nnode
        quiver(x(1, i), x(2, i), Fp(1, i), Fp(2, i), 0, 'r-', 'LineWidth', 1, 'MaxHeadSize', 1);
    end
end

end

function [] = plot_triangle_below(ax, x, l)

fill(ax, [x(1), x(1)-0.5*sqrt(3)*l, x(1)+0.5*sqrt(3)*l, x(1)], ...
         [x(2), x(2)-l, x(2)-l, x(2)],'k');

end

function [] = plot_circle_at(ax, x, l)

th=linspace(0, 2*pi, 100);
fill(ax, l*sin(th)+x(1), l*cos(th)+x(2), 'k');

end