% x1: VG1
% x2: VG2
% x3: VB301
% x4: thetaG1
% x5: thetaG2
% x6: thetaB301
clear all
global V_G1_bc V_G2_bc X_G1_B301 X_G2_B301 N_G1_B301 N_G2_B301 P_G1_B301 P_G2_B301 Q_G1_B301_min Q_G2_B301_min Q_G1_B301_max Q_G2_B301_max
V_G1_bc = 1;
V_G2_bc = 1;
P_G1_B301 =721.2/1000;
P_G2_B301 =21.2/1000;
Transfo = readtable("lf_EM_Transfo.dat");
Gen = readtable("lf_EM_Gen.dat");
Bus = readtable("lf_EM_Bus.dat");
X_G1_B301 = Transfo.X(7)*1000/Transfo.SNOM(7)/100;
X_G2_B301 = Transfo.X(8)*1000/Transfo.SNOM(8)/100;

N_G1_B301 = Transfo.N(7)/100;
N_G2_B301 = Transfo.N(8)/100;

Q_G1_B301_min = (Gen.QMIN(1)-Bus.QLOAD(1))/1000;
Q_G2_B301_min = (Gen.QMIN(2)-Bus.QLOAD(2))/1000;
Q_G1_B301_max = (Gen.QMAX(1)-Bus.QLOAD(1))/1000;
Q_G2_B301_max = (Gen.QMAX(2)-Bus.QLOAD(2))/1000;

ObjectiveFunction = @simple_objective;
ConstraintFunction = @simple_constraint;
lb = [0.95 0.95 0.95 -360 -360 -360];   % Lower bounds
ub = [1.1 1.1 1.1 360 360 360];  % Upper bounds
x0 = [1 1 1 0 0 0]; 
[x,fval] = patternsearch(ObjectiveFunction,x0,[],[],[],[],lb,ub, ...
    ConstraintFunction)