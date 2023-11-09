p=5;
xk=-1:2/p:1;
x=-1:2/p:1;
[Q] = eval_interp_onedim_lagrange(xk, x);
hold on
for i=1:p+1
    plot(x,squeeze(Q(i,2,:)))
end
title('p=5')