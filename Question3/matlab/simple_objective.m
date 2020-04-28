function y = simple_objective(x)
global V_G1_bc V_G2_bc
%SIMPLE_OBJECTIVE Objective function for PATTERNSEARCH solver

%   Copyright 2004 The MathWorks, Inc.  

V_G1 = x(1,1);
V_G2 = x(1,2);
y = abs(V_G1-V_G1_bc) + abs(V_G2-V_G2_bc);
