clear all

%% Données

% Network

P_c0 = 3346.6; % MW
sigma = 0.05;
D = 0.01; %1/Hz
f_n = 50; % Hz

% Lines

P_310311 = 0.18; % MW
P_306313 = 1.17; 

% or 
% Q_310 = -147.9;

% Generator

G1_0 = 700; % MW
G2_0 = 0;
G3_0 = 375;
G4_0 = 250;
G5_0 = 375;
G6_0 = 800;
E1_0 = 66.1;
E2_0 = 174;
E3_0 = 0;
P_0 = [G1_0 G2_0 G3_0 E1_0 E2_0];

G1_N = 850; % MW
G2_N = 850;
G3_N = 405;
G4_N = 270;
G5_N = 405;
G6_N = 850;
E1_N = 4000;
E2_N = 4000;
E3_N = 4000;

% disturbance active power
sl = 602.5;
DP_c = sl + [0 0 G5_0 G3_0 G6_0 E2_0+E1_0-400];
P_N = [G1_N G2_N G3_N E1_N E2_N;
       G1_N G2_N G3_N E1_N E2_N;
       G1_N G2_N G3_N E1_N E2_N;
       G1_N G2_N 0 E1_N E2_N;
       G1_N G2_N G3_N E1_N E2_N;
       G1_N G2_N G3_N 0 0];


%% Computation


for i=1:6
    P_c0_cc(i) = P_c0 + DP_c(i);
    beta(i) = D * P_c0_cc(i) + 1/f_n * sum(P_N(i,:))/sigma;
    DP_m(i,:) = DP_c(i) .* P_N(i,:)./(f_n*beta(i)*sigma);
    DP_m_tot(i) = sum(DP_m(i,:));
    p_mi(i,:) = DP_m(i,:)/DP_m_tot(i); 
    P_m(i,:) = P_0 + DP_m(i,:);
    for j=1:length(P_N(1,:))
        if DP_m(i,j)==0
            P_m(i,j) = 0;
        end
    end
end

