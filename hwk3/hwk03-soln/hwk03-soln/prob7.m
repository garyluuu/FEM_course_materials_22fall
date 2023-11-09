%% Problem 2

EI = 1; L = 1; q0 = -1;
x = linspace(0, L, 1000);

% Exact solution
w_ex = (q0*x/(12*EI)).*(x.^3/2 - L*x.^2 + L^3/2);

% Weighted residuals
w_res_gal = -0.0129*sin(pi*x);
w_res_col = -0.0143*sin(pi*x);

% Ritz method
w_ritz_trig = -0.0131*sin(pi*x);
w_ritz_poly = 0.041666666667*(x.*(x-1)-x.^2.*(x-1).^2);

% Plot the approximate solutions and exact solution
fh1 = figure; ah1 = axes;
plot(ah1, x, w_ex, 'k-', 'linew', 2); hold on;
plot(ah1, x, w_res_gal, 'b--', 'linew', 2);
plot(ah1, x, w_res_col, 'r--', 'linew', 2);
plot(ah1, x, w_ritz_trig, 'c:', 'linew', 2);
plot(ah1, x, w_ritz_poly, 'g-.', 'linew', 2);

% Plot the errors
fh2 = figure; ah2 = axes;
plot(ah2, x, abs(w_res_gal-w_ex), 'b--', 'linew', 2); hold on;
plot(ah2, x, abs(w_res_col-w_ex), 'r--', 'linew', 2);
plot(ah2, x, abs(w_ritz_trig-w_ex), 'c:', 'linew', 2);
plot(ah2, x, abs(w_ritz_poly-w_ex), 'g-.', 'linew', 2);
set(ah2, 'yscale', 'log');

% Plot the residuals
R_res_gal = -0.0129*pi^4*sin(pi*x)-q0;
R_res_col = -0.0143*pi^4*sin(pi*x)-q0;
R_ritz_trig = -0.0129*pi^4*sin(pi*x)-q0;
R_ritz_poly = 0.041666666667*24-q0;

fh3 = figure; ah3 = axes;
plot(ah3, x, abs(R_res_gal), 'b--', 'linew', 2); hold on;
plot(ah3, x, abs(R_res_col), 'r--', 'linew', 2);
plot(ah3, x, abs(R_ritz_trig), 'c:', 'linew', 2);
plot(ah3, x, abs(R_ritz_poly), 'g-.', 'linew', 2);

% Errors
dx = x(2)-x(1);
e_res_gal = dx*sum((w_res_gal(1:end-1)-w_ex(1:end-1)).^2)
e_res_col = dx*sum((w_res_col(1:end-1)-w_ex(1:end-1)).^2)
e_ritz_trig = dx*sum((w_ritz_trig(1:end-1)-w_ex(1:end-1)).^2)
e_ritz_poly = dx*sum((w_ritz_poly(1:end-1)-w_ex(1:end-1)).^2)