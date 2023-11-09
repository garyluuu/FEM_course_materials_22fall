
syms x y x1 x2 y1 y2

phi = [(x2-x)*(y2-y)/(x2-x1)/(y2-y1); ...
       (x-x1)*(y2-y)/(x2-x1)/(y2-y1); ...
       (x2-x)*(y-y1)/(x2-x1)/(y2-y1); ...
       (x-x1)*(y-y1)/(x2-x1)/(y2-y1)];
dphi = [diff(phi, x), diff(phi, y)];

K = int(int(dphi*dphi', x, x1, x2), y, y1, y2);
F = int(subs(phi, x, x1), y, y1, y2); % only if element touches bnd1