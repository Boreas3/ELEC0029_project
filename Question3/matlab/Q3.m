%% Data
close all
% base values
S_b = 100; % MVA
V_b1 = 20;
V_b2 = 380;
n_b = V_b2/V_b1;
Z_b1 = V_b1^2/S_b;
Z_b2 = V_b2^2/S_b;

% Transfo G1 - 301
P_G1 = 721.17053/S_b;
S_g1 = 1000;
R_tf_g1 = 0.23/100 * S_b/S_g1;
X_tf_g1 = 10.7/100 * S_b/S_g1;
n_tf_g1 = 1.0311;
phY_tf_g1 = 1/(R_tf_g1 + j*X_tf_g1);
eta_tf_g1 = angle(phY_tf_g1);
Y_tf_g1 = abs(phY_tf_g1);
phy_tf_g1_ch = -phY_tf_g1*1/n_tf_g1;

phY_g1 = (-1.9474163     +   90.597198     *j) * -n_tf_g1;
Y_g1 = abs(phY_g1);
eta_g1 = angle(phY_g1);
phZ_g1 = 1/phY_g1;
R_g1 = real(phZ_g1);
X_g1 = imag(phZ_g1);

% Transfo G2 - 301
P_G2 = 21.2/S_b;
S_g2 = 1000;
R_tf_g2 = 0.117/100 * S_b/S_g2;
X_tf_g2 = 9.854/100 * S_b/S_g2;
n_tf_g2 = 100.82/100;
phY_tf_g2 = 1/(R_tf_g2 + j*X_tf_g2);
eta_tf_g2 = angle(phY_tf_g2);
Y_tf_g2 = abs(phY_tf_g2);

% Tension bus 301
V_301p = 1.0009535 * V_b2; % valeur initial
V_max_301 = 395.2; % valeur cherchée
V_301 = V_max_301/V_b2; % pu


%% Computation

% 1)

V_G1 = 0.93:0.005:1.1;

V_301n = V_301/n_tf_g1;
Y = Y_tf_g1;
eta = eta_tf_g1;

theta = acos((Y * cos(eta) .* V_G1.^2 - P_G1)./(Y .* V_G1 .* V_301n)) + eta;
Q_G1 = -Y*sin(eta).*V_G1.^2 - Y .* V_G1 .* V_301n .* sin (theta - eta);
phas_V_G1 = V_G1 .* cos(theta) + j*V_G1 .* sin(theta);

figure
plot(V_G1,Q_G1*S_b)
xlabel('Voltage of bus G1 (pu)')
ylabel('Q in transformer "TG1-301" in Mvar')

% figure
% plot(V_G1,theta*180/pi)

I_G1_1 = (P_G1 - j.*Q_G1)./conj(phas_V_G1);
I_G1_2 = (phas_V_G1 - V_301n)/(R_g1+j*X_g1);


% Graphique de vérification

% figure
% plot(V_G1,I_G1_1,'r',V_G1,I_G1_2,'o')
% figure
% plot(V_G1,imag(I_G1_1),'r',V_G1,imag(I_G1_2),'o')
% figure
% plot(V_G1,abs(I_G1_1),'r',V_G1,abs(I_G1_2),'o')

% 2)

V_G2 = 1:0.005:1.1;

V_301n2 = V_301/n_tf_g2;
Y = Y_tf_g2;
eta = eta_tf_g2;

theta2 = acos((Y * cos(eta) * V_G2.^2 - P_G2)./(Y .* V_G2 .* V_301n2)) + eta;
Q_G2 = -Y*sin(eta) .* V_G2.^2 - Y * V_G2 * V_301n2 .* sin (theta2 - eta);
phas_V_G2 = V_G2 .* cos(theta2) + j*V_G2 .* sin(theta2);

figure
plot(V_G2,Q_G2*S_b)
xlabel('Voltage of bus G2 (pu)')
ylabel('Q in transformer "TG2-301" in Mvar')

I_G2_1 = (P_G2 - j.*Q_G2)./conj(phas_V_G2);
I_G2_2 = (phas_V_G2 - V_301n2)/(R_tf_g2+j*X_tf_g2);


% % Graphique de vérification
% 
% figure
% plot(V_G2,I_G2_1,'r',V_G2,I_G2_2,'o')
% figure
% plot(V_G2,imag(I_G2_1),'r',V_G2,imag(I_G2_2),'o')
% figure
% plot(V_G2,abs(I_G2_1),'r',V_G2,abs(I_G2_2),'o')

