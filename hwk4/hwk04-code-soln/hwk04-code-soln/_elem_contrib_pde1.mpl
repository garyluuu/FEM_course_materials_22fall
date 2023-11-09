
phi1 := (x2-x)*(y2-y)/(x2-x1)/(y2-y1);
phi2 := (x-x1)*(y2-y)/(x2-x1)/(y2-y1);
phi3 := (x2-x)*(y-y1)/(x2-x1)/(y2-y1);
phi4 := (x-x1)*(y-y1)/(x2-x1)/(y2-y1);

Dphi1Dx := diff(phi1, x);
Dphi1Dy := diff(phi1, y);
Dphi2Dx := diff(phi2, x);
Dphi2Dy := diff(phi2, y);
Dphi3Dx := diff(phi3, x);
Dphi3Dy := diff(phi3, y);
Dphi4Dx := diff(phi4, x);
Dphi4Dy := diff(phi4, y);

K11 := simplify(int(int(Dphi1Dx*Dphi1Dx+Dphi1Dy*Dphi1Dy, x=x1..x2), y=y1..y2));
K21 := simplify(int(int(Dphi2Dx*Dphi1Dx+Dphi2Dy*Dphi1Dy, x=x1..x2), y=y1..y2));
K31 := simplify(int(int(Dphi3Dx*Dphi1Dx+Dphi3Dy*Dphi1Dy, x=x1..x2), y=y1..y2));
K41 := simplify(int(int(Dphi4Dx*Dphi1Dx+Dphi4Dy*Dphi1Dy, x=x1..x2), y=y1..y2));
K12 := simplify(int(int(Dphi1Dx*Dphi2Dx+Dphi1Dy*Dphi2Dy, x=x1..x2), y=y1..y2));
K22 := simplify(int(int(Dphi2Dx*Dphi2Dx+Dphi2Dy*Dphi2Dy, x=x1..x2), y=y1..y2));
K32 := simplify(int(int(Dphi3Dx*Dphi2Dx+Dphi3Dy*Dphi2Dy, x=x1..x2), y=y1..y2));
K42 := simplify(int(int(Dphi4Dx*Dphi2Dx+Dphi4Dy*Dphi2Dy, x=x1..x2), y=y1..y2));
K13 := simplify(int(int(Dphi1Dx*Dphi3Dx+Dphi1Dy*Dphi3Dy, x=x1..x2), y=y1..y2));
K23 := simplify(int(int(Dphi2Dx*Dphi3Dx+Dphi2Dy*Dphi3Dy, x=x1..x2), y=y1..y2));
K33 := simplify(int(int(Dphi3Dx*Dphi3Dx+Dphi3Dy*Dphi3Dy, x=x1..x2), y=y1..y2));
K43 := simplify(int(int(Dphi4Dx*Dphi3Dx+Dphi4Dy*Dphi3Dy, x=x1..x2), y=y1..y2));
K14 := simplify(int(int(Dphi1Dx*Dphi4Dx+Dphi1Dy*Dphi4Dy, x=x1..x2), y=y1..y2));
K24 := simplify(int(int(Dphi2Dx*Dphi4Dx+Dphi2Dy*Dphi4Dy, x=x1..x2), y=y1..y2));
K34 := simplify(int(int(Dphi3Dx*Dphi4Dx+Dphi3Dy*Dphi4Dy, x=x1..x2), y=y1..y2));
K44 := simplify(int(int(Dphi4Dx*Dphi4Dx+Dphi4Dy*Dphi4Dy, x=x1..x2), y=y1..y2));

F1 := simplify(int(subs(x=x1, phi1), y=y1..y2));
F2 := simplify(int(subs(x=x1, phi2), y=y1..y2));
F3 := simplify(int(subs(x=x1, phi3), y=y1..y2));
F4 := simplify(int(subs(x=x1, phi4), y=y1..y2));
