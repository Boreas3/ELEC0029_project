function [c, ceq] = simple_constraint(x)
global Y_G1_B301 Y_G2_B301 eta_G1_B301 eta_G2_B301 N_G1_B301 N_G2_B301 P_G1_B301 P_G2_B301 Q_G1_B301_min Q_G2_B301_min Q_G1_B301_max Q_G2_B301_max
%SIMPLE_CONSTRAINT Nonlinear inequality constraints.

%   Copyright 2005-2007 The MathWorks, Inc.
V_G1 = x(1);
V_G2 = x(2);
V_B301 = x(3);
theta_G1 = x(4);
theta_G2 = x(5);
theta_B301 = x(6);

Q_G1_B301 = abs(Y_G1_B301)*(-sind(eta_G1_B301)*V_G1^2 - V_G1*V_B301/N_G1_B301 * sind(theta_G1 - theta_B301 - eta_G1_B301));
Q_G2_B301 = abs(Y_G2_B301)*(-sind(eta_G2_B301)*V_G2^2 - V_G2*V_B301/N_G2_B301 * sind(theta_G2 - theta_B301 - eta_G2_B301));

c = [Q_G1_B301 - Q_G1_B301_max;
     Q_G1_B301_min - Q_G1_B301;
     Q_G2_B301 - Q_G2_B301_max;
     Q_G2_B301_min - Q_G2_B301];
% No nonlinear equality constraints:
ceq = [P_G1_B301 - abs(Y_G1_B301)*(cosd(eta_G1_B301)*V_G1^2 - V_G1*V_B301/N_G1_B301 * cosd(theta_G1 - theta_B301 - eta_G1_B301));
       P_G2_B301 - abs(Y_G2_B301)*(cosd(eta_G2_B301)*V_G2^2 - V_G2*V_B301/N_G2_B301 * cosd(theta_G2 - theta_B301 - eta_G2_B301));
       V_B301*380 - 395.2];
