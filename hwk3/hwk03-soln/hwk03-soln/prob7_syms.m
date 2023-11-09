%%% Weighted residual

% Part ab
clear all;

syms x
L = 1; EI = 1; q0 = -1;
R = @(w) diff(diff(EI*diff(diff(w, x) , x), x), x) - q0;

varphi = 0;
phi(1,1) = sin(pi*x/L);
phi(2,1) = sin(2*pi*x/L);

K_gal = eval(int(phi*R(phi'), x, 0, L));
F_gal = eval(-int(phi*R(varphi), x, 0, L));
c_gal = K_gal\F_gal;

K_col = [eval(subs(R(phi'), x, 0.25)); ...
         eval(subs(R(phi'), x, 0.75))];
F_col = -[eval(subs(R(varphi), x, 0.25)); ...
          eval(subs(R(varphi), x, 0.75))];         
c_col = K_col\F_col;

% Part cd
clear all;

syms x;
L = 1; EI = 1; q0 = -1;
B = @(v, w) int(diff(v, x, 2)*EI*diff(w, x, 2), x, 0, L);
l = @(v) int(v*q0, x, 0, L);

varphi = 0;
phi(1,1) = sin(pi*x/L);
phi(2,1) = sin(2*pi*x/L);

K_ritz1 = eval(B(phi, phi'));
F_ritz1 = eval(l(phi)-B(phi, varphi));
c_ritz1 = K_ritz1\F_ritz1;

varphi = 0;
phi(1,1) = x*(x-L);
phi(2,1) = x^2*(x-L)^2;

K_ritz2 = eval(B(phi, phi'));
F_ritz2 = eval(l(phi)-B(phi, varphi));
c_ritz2 = K_ritz2\F_ritz2;