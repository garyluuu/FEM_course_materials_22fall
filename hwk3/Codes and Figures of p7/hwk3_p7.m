%% Weighted residual-Galerkin

syms x

L = 1;

varphi=0;
phi1=sin(pi*x/L);
phi2=sin(2*pi*x/L);

EI=1;
q0=-1;

R = @(w) diff(diff(EI*diff(diff(w, x))))-q0; 

K11 = int(phi1*R(phi1), x, 0, L); % eval(K11)
K12 = int(phi1*R(phi2), x, 0, L); % eval(K12)
K21 = int(phi2*R(phi1), x, 0, L); % eval(K21)
K22 = int(phi2*R(phi2), x, 0, L); % eval(K22)

f1 = -int(phi1*R(varphi), x, 0, L);
f2 = -int(phi2*R(varphi), x, 0, L);

K = eval([K11, K12; K21, K22]);
f = eval([f1; f2]);

c = K\f;
uh = varphi + c(1)*phi1 + c(2)*phi2;
ue = -1/24*x^4+1/12*x^3-1/24*x; % Exact
subplot(1,2,1)
ezplot(uh,[0,1])
hold on
ezplot(ue,[0,1])
legend('uh','ue')

e=abs(ue-uh);
subplot(1,2,2)
ezplot(e,[0,1]);
E = sqrt(int((ue-uh)^2, x, 0, L));eval(E)
%% Weighted residual-Collocation

syms x

L = 1;

varphi=0;
phi1=sin(pi*x/L);
phi2=sin(2*pi*x/L);

x1=0.25;
x2=0.75;

EI=1;
q0=-1;

R = @(w) diff(diff(EI*diff(diff(w, x))))-q0; 

K11 = subs(R(phi1),x,x1); % eval(K11)
K12 = subs(R(phi2),x,x1); % eval(K12)
K21 = subs(R(phi1),x,x2); % eval(K21)
K22 = subs(R(phi2),x,x2); % eval(K22)

f1 = -subs(R(varphi),x,x1);
f2 = -subs(R(varphi),x,x2);

K = eval([K11, K12; K21, K22]);
f = eval([f1; f2]);

c = K\f;
uh = varphi + c(1)*phi1 + c(2)*phi2;
ue = -1/24*x^4+1/12*x^3-1/24*x; % Exact
subplot(1,2,1)
ezplot(uh,[0,1])
hold on
ezplot(ue,[0,1])
legend('uh','ue')

e=abs(ue-uh);
subplot(1,2,2)
ezplot(e,[0,1]);
E = sqrt(int((ue-uh)^2, x, 0, L));eval(E)
%% Ritz method 1

syms x

L = 1;

B = @(v,w) int(diff(diff(v, x))*diff(diff(w, x)), x, 0, L);
l = @(v) int(-v, x, 0, L);

varphi=0;
phi1=sin(pi*x/L);
phi2=sin(2*pi*x/L);

K11 = B(phi1, phi1); % eval(K11)
K12 = B(phi1, phi2); % eval(K12)
K21 = B(phi2, phi1); % eval(K21)
K22 = B(phi2, phi2); % eval(K22)

f1 = l(phi1)-B(phi1,varphi);
f2 = l(phi2)-B(phi2,varphi);

K = eval([K11, K12; K21, K22]);
f = eval([f1; f2]);

c = K\f;
uh = varphi + c(1)*phi1 + c(2)*phi2;
ue = -1/24*x^4+1/12*x^3-1/24*x; % Exact
subplot(1,2,1)
ezplot(uh,[0,1])
hold on
ezplot(ue,[0,1])
legend('uh','ue')

e=abs(ue-uh);
subplot(1,2,2)
ezplot(e,[0,1]);
E = sqrt(int((ue-uh)^2, x, 0, L));eval(E)
%% Ritz method 2

syms x

L = 1;

B = @(v,w) int(diff(diff(v, x))*diff(diff(w, x)), x, 0, L);
l = @(v) int(-v, x, 0, L);

varphi=0;
phi1=x*(x-L);
phi2=x^2*(x-L)^2;

K11 = B(phi1, phi1); % eval(K11)
K12 = B(phi1, phi2); % eval(K12)
K21 = B(phi2, phi1); % eval(K21)
K22 = B(phi2, phi2); % eval(K22)

f1 = l(phi1)-B(phi1,varphi);
f2 = l(phi2)-B(phi2,varphi);

K = eval([K11, K12; K21, K22]);
f = eval([f1; f2]);

c = K\f;
uh = varphi + c(1)*phi1 + c(2)*phi2;
ue = -1/24*x^4+1/12*x^3-1/24*x; % Exact
subplot(1,2,1)
ezplot(uh,[0,1])
hold on
ezplot(ue,[0,1])
legend('uh','ue')

e=abs(ue-uh);
subplot(1,2,2)
ezplot(e,[0,1]);
E = sqrt(int((ue-uh)^2, x, 0, L));eval(E)