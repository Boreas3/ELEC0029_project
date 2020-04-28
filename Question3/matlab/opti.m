% x1: VG1
% x2: VG2
% x3: VB301
% x4: thetaG1
% x5: thetaG2
% x6: thetaB301
clear all
global V_G1_bc V_G2_bc Y_G1_B301 Y_G2_B301 Y_B301_B302 Y_B301_B304 eta_G1_B301 eta_G2_B301 eta_B301_B302 eta_B301_B304 f_B302 f_B304 N_G1_B301 N_G2_B301 P_G1_B301 P_G2_B301 Q_G1_B301_min Q_G2_B301_min Q_G1_B301_max Q_G2_B301_max
V_G1_bc = 1;
V_G2_bc = 1;
P_G1_B301 =721.2/1000;
P_G2_B301 =21.2/1000;
Transfo = readtable("lf_EM_Transfo.dat");
Gen = readtable("lf_EM_Gen.dat");
Bus = readtable("lf_EM_Bus.dat");

Y_G1_B301 = -(-1.9474163 + 90.597198*1i)/10;
Y_G2_B301 = -(-1.1949584 + 100.64206*1i)/10;
Y_B301_B302 = -(-65.908653 + 683.23132*1i)/10;
Y_B301_B304 = -((-17.835026 + 189.88760*1i)+(-17.835026 + 189.88760*1i)+(-24.291470 + 212.74883*1i))/10;
eta_G1_B301 = angle(Y_G1_B301) * 180/pi;
eta_G2_B301 = angle(Y_G2_B301) * 180/pi;
eta_B301_B302 = angle(Y_B301_B302) * 180/pi;
eta_B301_B304 = angle(Y_B301_B304) * 180/pi;
V_B301 = [1.0010 1.0264 1.0371 1.0392 1.0401]';
V_B302 = [0.999 1.0245 1.0354 1.0375 1.0383]';
V_B304 = [0.9968 1.0191 1.0285 1.0304 1.0311]';
f_B302 = fit(V_B301,V_B302,'poly2');
f_B304 = fit(V_B301,V_B304,'poly2');

N_G1_B301 = Transfo.N(7)/100;
N_G2_B301 = Transfo.N(8)/100;

Q_G1_B301_min = (Gen.QMIN(1)-Bus.QLOAD(1))/1000;
Q_G2_B301_min = (Gen.QMIN(2)-Bus.QLOAD(2))/1000;
Q_G1_B301_max = (Gen.QMAX(1)-Bus.QLOAD(1))/1000;
Q_G2_B301_max = (Gen.QMAX(2)-Bus.QLOAD(2))/1000;

ObjectiveFunction = @simple_objective;
ConstraintFunction = @simple_constraint;
lb = [0.95 0.95 0.95 0.95 0.95 0; -360 -360 -360 -360 0 -360; -1000 -1000 -1000 -1000 -1000 -1000; -1000 -1000 -1000 -1000 -1000 -1000];   % Lower bounds
ub = [1.1 1.1 1.1 1.1, 1.1 0; 360 360 360 360 360 0; 1000 1000 1000 1000 1000 1000; 1000 1000 1000 1000 1000 1000];  % Upper bounds
x0 = [1 1 1 1 1 0; 0 0 0 0 0 0; 1 1 1 1 1 1; 1 1 1 1 1 1]; 
options = optimoptions(@patternsearch,'PlotFcn',{@psplotbestf,@psplotmaxconstr}, ...
                                      'Display','iter','MaxFunEvals', 1e7);
[x,fval] = patternsearch(ObjectiveFunction,x0,[],[],[],[],lb,ub, ...
    ConstraintFunction,options);
