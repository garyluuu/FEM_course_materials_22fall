function [] = visualize_fem(u, msh, plot_nodes, plot_elem)
%VISUALIZE_FEM Visualize finite element mesh and solution (1d, 2d).
%
%Input arguments
%---------------
%   U, MSH : see notation.m
%
%   PLOT_NODES : bool : Whether to plot nodes
%
%   PLOT_ELEM : bool : Whether to plot elements
%
%Output arguments
%----------------
%   None

if nargin < 3, plot_nodes = false; end
if nargin < 4, plot_elem = false; end

% Extract information from input
xcg = msh.xcg; e2vcg = msh.e2vcg;
ndim = size(xcg, 1);
nelem = size(e2vcg, 2);

% Create figure, axes (make sure to add onto axes, not overwrite)
figure; ax = axes('NextPlot', 'add');

if ndim == 1 % 1d
    % Plot nodes, if requested; nodes on boundary of elements plotted with
    % o and x, interior nodes plotted with only o.
    if plot_nodes
        plot(ax, xcg(1, e2vcg(1, 1)), 0, 'bo');
        for e = 1:nelem
            plot(ax, xcg(1, e2vcg(:, e)), 0*xcg(1, e2vcg(:, e)), 'bo');
            plot(ax, xcg(1, e2vcg(end, e)), 0, 'bx');
        end
    end
    
    % Plot elements, if requested
    if plot_elem
        for e = 1:nelem
            plot(ax, [xcg(1, e2vcg(1, e)), xcg(1, e2vcg(end, e))], [0, 0], 'k-', 'linew', 2);
        end
    end
    
    % If the solution is not empty, plot it
    if ~isempty(u)
        for e = 1:nelem
            plot(xcg(1, e2vcg(:, e)), u(e2vcg(:, e)), 'b-', 'linew', 2);
        end
    end
elseif ndim == 2 % 2d
    % Extract index that will extract only vertices of polygon
    idx = [1, 2, 4, 3];
    
    % Plot solution and elements, as requested
    if plot_elem && ~isempty(u)
        patch(ax, 'Vertices', xcg', 'Faces', e2vcg(idx, :)', 'FaceVertexCData', u(:), 'FaceColor', 'interp');
    elseif plot_elem && isempty(u)
        patch(ax, 'Vertices', xcg', 'Faces', e2vcg(idx, :)', 'FaceColor', [0.8, 1.0, 0.8]);
    elseif ~plot_elem && ~isempty(u)
        patch(ax, 'Vertices', xcg', 'Faces', e2vcg(idx, :)', 'FaceVertexCData', u(:), 'FaceColor', 'interp', 'EdgeColor', 'none');
    end
    
    % Plot nodes, if requested
    if plot_nodes, plot(ax, xcg(1, :), xcg(2, :), 'bo'); end
else
    error('Dimension not supported');
end

end