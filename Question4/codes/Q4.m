clear all
close all

%% data

% Loads

Part1
P_101 = Bus.PLOAD(7);
Q_101 = Bus.QLOAD(7);
phi_101 = atan(Q_101/P_101);

P_102 = Bus.PLOAD(8);
Q_102 = Bus.QLOAD(8);
phi_102 = atan(Q_102/P_102);

P_103 = Bus.PLOAD(9);
Q_103 = Bus.QLOAD(9);
phi_103 = atan(Q_103/P_103);

P_106 = Bus.PLOAD(12);
Q_106 = Bus.QLOAD(12);
phi_106 = atan(Q_106/P_106);

P = [P_101 P_102 P_103 P_106];
Q = [Q_101 Q_102 Q_103 Q_106];
phi = [phi_101 phi_102 phi_103 phi_106];

P_tot = sum(P);
f_P = P/P_tot;

Inc = linspace(1,2,100);

for i=1:length(Inc)
    P_inc(i,:) = Inc(i) * P;
    deltaP(i,:) = P_inc(i,:) - P;
    P_tot_inc(i) = sum(P_inc(i,:));
    f_P_inc(i,:) = P_inc(i,:)/P_tot_inc(i);
    Q_inc(i,:) = P_inc(i,:) .* tan(phi);
    deltaQ(i,:) = Q_inc(i,:) - Q;
    PQ_inc(:,2*i-1) = transpose(P_inc(i,:));
    PQ_inc(:,2*i) = transpose(Q_inc(i,:));
    deltaPQ(:,2*i-1) =  transpose(deltaP(i,:));
    deltaPQ(:,2*i) = transpose(deltaQ(i,:));
end

% Voltage evolution

V_E2 = 1.07 * 380; % Volt

V_101 = [1.0307 1.032 1.0276 1.0291 1.0244 1.0261]*150; 
theta_101 = [-13.26 -9.57 -16.07 -11.17 -18.95 -12.8];
V_102 = [1.0021 1.004 0.9947 0.996 0.9895 0.9915]*150;
theta_102 = [-12.23 -12.98 -18.46 -14.51 -21.04 -16.05];
V_103 = [0.9997 0.9982 0.9925 0.9942 0.9873 0.9901]*150;
theta_103 = [-11.84 -12.57 -17.41 -14.05 -19.81 -15.54];
V_106 = [1.0091 1.0077 1.0005 1.0042 0.9958 1.005]*150;
theta_106 = [-11.24 -11.92 -17.22 -13.29 -19.63 -14.68];

P_101_ev = [P_101 transpose(P_inc(:,1))];
P_102_ev = [P_102 transpose(P_inc(:,2))];
P_103_ev = [P_103 transpose(P_inc(:,3))];
P_106_ev = [P_106 transpose(P_inc(:,4))];

dP_101_ev = [0 transpose(deltaP(:,1))];
dP_102_ev = [0 transpose(deltaP(:,2))];
dP_103_ev = [0 transpose(deltaP(:,3))];
dP_106_ev = [0 transpose(deltaP(:,4))];

Q_101_ev = [Q_101 transpose(Q_inc(:,1))];
Q_102_ev = [Q_102 transpose(Q_inc(:,2))];
Q_103_ev = [Q_103 transpose(Q_inc(:,3))];
Q_106_ev = [Q_106 transpose(Q_inc(:,4))];

dQ_101_ev = [0 transpose(deltaQ(:,1))];
dQ_102_ev = [0 transpose(deltaQ(:,2))];
dQ_103_ev = [0 transpose(deltaQ(:,3))];
dQ_106_ev = [0 transpose(deltaQ(:,4))];

%X_101 = -V_E2/380 * V_101/150 ./(P_101_ev/100) .* sind(theta_101); % pu
%X_101_2 = (-(V_101/150).^2 +  V_E2/380 * V_101/150 .* cosd(theta_101))./(Q_101_ev/100);

figure
plot(dP_101_ev/100,(V_101/150)/(V_E2/380))
figure
plot(dP_102_ev/100,(V_102/150)/(V_E2/380))
figure
plot(dP_103_ev/100,(V_103/150)/(V_E2/380))
figure
plot(dP_106_ev/100,(V_106/150)/(V_E2/380))
