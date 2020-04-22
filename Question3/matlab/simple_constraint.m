function [c, ceq] = simple_constraint(x)
global X_G1_B301 X_G2_B301 N_G1_B301 N_G2_B301 P_G1_B301 P_G2_B301 Q_G1_B301_min Q_G2_B301_min Q_G1_B301_max Q_G2_B301_max
%SIMPLE_CONSTRAINT Nonlinear inequality constraints.

%   Copyright 2005-2007 The MathWorks, Inc.
V_G1 = x(1);
V_G2 = x(2);
V_B301 = x(3);
theta_G1 = x(4);
theta_G2 = x(5);
theta_B301 = x(6);

c = [X_G1_B301^-1*(V_G1^2 - V_G1*V_B301/N_G1_B301 * cosd(theta_G1 - theta_B301)) - Q_G1_B301_max;
     Q_G1_B301_min - X_G1_B301^-1*(V_G1^2 - V_G1*V_B301/N_G1_B301 * cosd(theta_G1 - theta_B301));
     X_G2_B301^-1*(V_G2^2 - V_G2*V_B301/N_G2_B301 * cosd(theta_G2 - theta_B301)) - Q_G2_B301_max;
     Q_G2_B301_min - X_G2_B301^-1*(V_G2^2 - V_G2*V_B301/N_G2_B301 * cosd(theta_G2 - theta_B301))];
% No nonlinear equality constraints:
ceq = [P_G1_B301 - X_G1_B301^-1*V_G1*V_B301/N_G1_B301 * sind(theta_G1 - theta_B301);
       P_G2_B301 - X_G2_B301^-1*V_G2*V_B301/N_G2_B301 * sind(theta_G2 - theta_B301);
       V_B301*380 - 395.2];
