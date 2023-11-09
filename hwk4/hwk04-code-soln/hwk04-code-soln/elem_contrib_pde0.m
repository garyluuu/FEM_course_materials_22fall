
syms x x1 x2

phi = [(x2-x)/(x2-x1); (x-x1)/(x2-x1)];
dphi = diff(phi, x);

K = int(dphi*dphi'-phi*phi', x, x1, x2);
F = -int(x^2*phi, x, x1, x2); % without bnd term