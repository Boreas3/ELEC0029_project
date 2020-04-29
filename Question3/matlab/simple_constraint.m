function [c, ceq] = simple_constraint(x)
global Y_G1_B301 Y_G2_B301 Y_B301_B302 Y_B301_B304_1 Y_B301_B304_2 Y_B301_B304_3 eta_G1_B301 eta_G2_B301 eta_B301_B302 eta_B301_B304_1 eta_B301_B304_2 eta_B301_B304_3 f_B302 f_B304 N_G1_B301 N_G2_B301 P_G1_B301 P_G2_B301 Q_G1_B301_min Q_G2_B301_min Q_G1_B301_max Q_G2_B301_max
%SIMPLE_CONSTRAINT Nonlinear inequality constraints.

%   Copyright 2005-2007 The MathWorks, Inc.
%x(1,1:3) = Voltage
%x(2,1:3) = Angle
%x(3,1:3) = Active power injected in network from bus
%x(4,1:3) = Reactive power injected in network from bus
V_G1 = x(1,1);
V_G2 = x(1,2);
V_B301 = x(1,3);
V_B302 = x(1,4);
V_B304 = x(1,5);
theta_G1 = x(2,1);
theta_G2 = x(2,2);
theta_B301 = x(2,3);
theta_B302 = x(2,4);
theta_B304 = x(2,5);


c = [
     x(4,1) - Q_G1_B301_max*0.99;
     Q_G1_B301_min - x(4,1);
     x(4,2) - Q_G2_B301_max*0.99;% This 0.99 factor is necessary. Otherwise, 
                                 % the software makes it reaches its
                                 % its maximal reactive power production,
                                 % and the resulting voltage is a little
                                 % too optimistic.
     Q_G2_B301_min - x(4,2)];
% No nonlinear equality constraints:
ceq = [x(3,1) - abs(Y_G1_B301)*(cosd(eta_G1_B301)*V_G1^2 - V_G1*V_B301/N_G1_B301 * cosd(theta_G1 - theta_B301 - eta_G1_B301));
       x(3,2) - abs(Y_G2_B301)*(cosd(eta_G2_B301)*V_G2^2 - V_G2*V_B301/N_G2_B301 * cosd(theta_G2 - theta_B301 - eta_G2_B301));        
       x(3,3) - abs(Y_G1_B301)*(cosd(eta_G1_B301)*(V_B301/N_G1_B301)^2 - V_G1*V_B301/N_G1_B301 * cosd(theta_B301 - theta_G1 - eta_G1_B301));
       x(3,4) - abs(Y_G2_B301)*(cosd(eta_G2_B301)*(V_B301/N_G2_B301)^2 - V_G2*V_B301/N_G2_B301 * cosd(theta_B301 - theta_G2 - eta_G2_B301));
       x(3,5) - abs(Y_B301_B302)*(cosd(eta_B301_B302)*V_B301^2 - V_B301*V_B302 * cosd(theta_B301 - theta_B302 - eta_B301_B302));
       x(3,6) - abs(Y_B301_B304_1)*(cosd(eta_B301_B304_1)*V_B301^2 - V_B301*V_B304 * cosd(theta_B301 - theta_B304 - eta_B301_B304_1));
       x(3,7) - abs(Y_B301_B304_2)*(cosd(eta_B301_B304_2)*V_B301^2 - V_B301*V_B304 * cosd(theta_B301 - theta_B304 - eta_B301_B304_2));
       x(3,8) - abs(Y_B301_B304_3)*(cosd(eta_B301_B304_3)*V_B301^2 - V_B301*V_B304 * cosd(theta_B301 - theta_B304 - eta_B301_B304_3));
       P_G1_B301 - x(3,1);
       P_G2_B301 - x(3,2);
       x(3,3)+x(3,4)+x(3,5)+x(3,6)+x(3,7)+x(3,8);
       x(4,1) - abs(Y_G1_B301)*(-sind(eta_G1_B301)*V_G1^2 - V_G1*V_B301/N_G1_B301 * sind(theta_G1 - theta_B301 - eta_G1_B301));
       x(4,2) - abs(Y_G2_B301)*(-sind(eta_G2_B301)*V_G2^2 - V_G2*V_B301/N_G2_B301 * sind(theta_G2 - theta_B301 - eta_G2_B301));
       x(4,3) - abs(Y_G1_B301)*(-sind(eta_G1_B301)*(V_B301/N_G1_B301)^2 - V_G1*V_B301/N_G1_B301 * sind(theta_B301 - theta_G1 - eta_G1_B301));
       x(4,4) - abs(Y_G2_B301)*(-sind(eta_G2_B301)*(V_B301/N_G2_B301)^2 - V_G2*V_B301/N_G2_B301 * sind(theta_B301 - theta_G2 - eta_G2_B301));
       x(4,5) - abs(Y_B301_B302)*(-sind(eta_B301_B302)*V_B301^2 - V_B301*V_B302 * sind(theta_B301 - theta_B302 - eta_B301_B302));
       x(4,6) - abs(Y_B301_B304_1)*(-sind(eta_B301_B304_1)*V_B301^2 - V_B301*V_B304 * sind(theta_B301 - theta_B304 - eta_B301_B304_1));
       x(4,7) - abs(Y_B301_B304_2)*(-sind(eta_B301_B304_2)*V_B301^2 - V_B301*V_B304 * sind(theta_B301 - theta_B304 - eta_B301_B304_2));
       x(4,8) - abs(Y_B301_B304_3)*(-sind(eta_B301_B304_3)*V_B301^2 - V_B301*V_B304 * sind(theta_B301 - theta_B304 - eta_B301_B304_3));
       x(4,3)+x(4,4)+x(4,5)+x(4,6)+x(4,7)+x(4,8);
       V_B302 - f_B302(V_B301);
       V_B304 - f_B304(V_B301);
       V_B301*380 - 395.2];
