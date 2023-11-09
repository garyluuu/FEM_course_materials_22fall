
phi1 := (x2-x)/(x2-x1);
dphi1 := diff(phi1, x);

phi2 := (x-x1)/(x2-x1);
dphi2 := diff(phi2, x);

K11 := int(dphi1*dphi1-phi1*phi1, x=x1..x2);
K12 := int(dphi1*dphi2-phi1*phi2, x=x1..x2);
K21 := int(dphi2*dphi1-phi2*phi1, x=x1..x2);
K22 := int(dphi2*dphi2-phi2*phi2, x=x1..x2);

F1 := -int(x^2*phi1, x=x1..x2);
F2 := -int(x^2*phi2, x=x1..x2);
