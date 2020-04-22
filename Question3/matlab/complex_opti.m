% x1: VG1
% x2: VG2
% x3: VB301
% x4: thetaG1
% x5: thetaG2
% x6: thetaB301
clear all
global V_G1_bc V_G2_bc Y0 eta N P_inj Q_min Q_max
[Y0, P_inj] = crea_matrix();
for i=1:28
    for j=1:28
        if i~= j
            Y0(i,j) = -Y0(i,j);
        end
    end
end
Y0 = Y0*10; % puissance de base différente par rapport à celle choisie
eta = angle(Y0)*180/pi;
Transfo = readtable("lf_EM_Transfo.dat");
Gen = readtable("lf_EM_Gen.dat");
Bus = readtable("lf_EM_Bus.dat");
Q_min = zeros(9,1);
Q_max = zeros(9,1);
Q_min(1:6) = (Gen.QMIN(1:6)-Bus.QLOAD(1:6))/1000;
Q_max(1:6) = (Gen.QMAX(1:6)-Bus.QLOAD(1:6))/1000;

N = zeros(28,28) + 1;
Nratio = Transfo.N/100;
N(13,15) = 1/Nratio(1);
N(15,13) = Nratio(1);

N(7,16) = 1/Nratio(2);
N(16,7) = Nratio(2);

N(11,20) = 1/Nratio(3);
N(20,11) = Nratio(3);

N(8,17) = 1/Nratio(4);
N(17,8) = Nratio(4);

N(12,18) = 1/Nratio(5);
N(18,12) = Nratio(5);

N(10,19) = 1/Nratio(6);
N(19,10) = Nratio(6);

N(14,1) = 1/Nratio(7);
N(1,14) = Nratio(7);

N(14,2) = 1/Nratio(8);
N(2,14) = Nratio(8);

N(7,3) = 1/Nratio(9);
N(3,7) = Nratio(9);

N(9,4) = 1/Nratio(10);
N(4,9) = Nratio(10);

N(11,5) = 1/Nratio(11);
N(5,11) = Nratio(11);

N(23,6) = 1/Nratio(12);
N(6,23) = Nratio(12);


V_G1_bc = 1;
V_G2_bc = 1;
ObjectiveFunction = @complex_objective;
ConstraintFunction = @complex_constraint;
lb = [0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95
    -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360 -360];   % Lower bounds
ub = [1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1
    360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360];  % Upper bounds
x0 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; 
[x,fval] = patternsearch(ObjectiveFunction,x0,[],[],[],[],lb,ub, ...
    ConstraintFunction);
