% x1: VG1
% x2: VG2
% x3: VB301
% x4: thetaG1
% x5: thetaG2
% x6: thetaB301
clear all
global V_G1_bc V_G2_bc Vnom Y0 eta N P_inj Q_inj P_gen P_load Q_load Q_min Q_max
Bus = readtable("lf_EM_Bus.dat");
P_load = Bus.PLOAD/1000;
Q_load = Bus.QLOAD/1000;
[Y0, P_inj, Q_inj, P_gen, Q_gen, Vnom, theta] = crea_matrix();
for i=1:28
    for j=1:28
        if i~= j
            Y0(i,j) = -Y0(i,j);
        end
    end
end
Y0 = Y0/10; % puissance de base différente par rapport à celle choisie
eta = angle(Y0)*180/pi;
Transfo = readtable("lf_EM_Transfo.dat");
Gen = readtable("lf_EM_Gen.dat");
Q_min = zeros(9,1);
Q_max = zeros(9,1);
Q_min(1:6) = Gen.QMIN(1:6)/1000;
Q_max(1:6) = Gen.QMAX(1:6)/1000;

N = zeros(28,28) + 1;
Nratio = Transfo.N/100;
N(13,15) = Nratio(1);
N(15,13) = Nratio(1);

N(7,16) = Nratio(2);
N(16,7) = Nratio(2);

N(11,20) = Nratio(3);
N(20,11) = Nratio(3);

N(8,17) = Nratio(4);
N(17,8) = Nratio(4);

N(12,18) = Nratio(5);
N(18,12) = Nratio(5);

N(10,19) = Nratio(6);
N(19,10) = Nratio(6);

N(14,1) = Nratio(7);
N(1,14) = Nratio(7);

N(14,2) = Nratio(8);
N(2,14) = Nratio(8);

N(7,3) = Nratio(9);
N(3,7) = Nratio(9);

N(9,4) = Nratio(10);
N(4,9) = Nratio(10);

N(11,5) = Nratio(11);
N(5,11) = Nratio(11);

N(23,6) = Nratio(12);
N(6,23) = Nratio(12);


V_G1_bc = 1;
V_G2_bc = 1;
ObjectiveFunction = @complex_objective;
ConstraintFunction = @complex_constraint;
lb_V = zeros(28,1) + 0.95;
lb_theta = zeros(28,1) - 360;
lb_P_inj = zeros(28,1) - 9999;
lb_Q_inj = zeros(28,1) - 9999;
lb_P_gen = zeros(28,1) - 9999;
lb_Q_gen = zeros(28,1) - 9999;
ub_V = zeros(28,1) + 1.1;
ub_theta = zeros(28,1) + 360;
ub_P_inj = zeros(28,1) + 9999;
ub_Q_inj = zeros(28,1) + 9999;
ub_P_gen = zeros(28,1) + 9999;
ub_Q_gen = zeros(28,1) + 9999;

lb = [lb_V, lb_theta, lb_P_inj, lb_Q_inj, lb_P_gen, lb_Q_gen]';   % Lower bounds
ub = [ub_V, ub_theta, ub_P_inj, ub_Q_inj, ub_P_gen, ub_Q_gen]';  % Upper bounds
x0 = [Vnom, theta, P_inj, Q_inj, P_gen, Q_gen]'; 

options = optimoptions(@patternsearch,'PlotFcn',{@psplotbestf,@psplotmaxconstr}, 'CompletePoll', 'on', ...
                                    'Display','iter','MaxFunEvals', 1e7, 'TolCon', 1e-2);
[x,fval] = patternsearch(ObjectiveFunction,x0,[],[],[],[],lb,ub, ...
  ConstraintFunction, options);
