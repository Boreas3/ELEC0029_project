clear all
%% Données

% Network

P_c0 = 3354.4; % MW
sigma = 0.05;
D = zeros(7,1) + 0.01; %1/Hz
f_n = 50; % Hz

% Lines

P_310311 = 0.2; % MW
P_306313 = 0.26; 

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
name_Part_Bus = ['G1'; 'G2'; 'G3'; 'E1'; 'E2']
sl = 613.4;
DP_c =[sl -P_310311 -P_306313 G5_0 G3_0 G6_0 -P_306313-P_310311+E2_0+E1_0-400];
P_N = [G1_N G2_N G3_N E1_N E2_N;
       G1_N G2_N G3_N E1_N E2_N;
       G1_N G2_N G3_N E1_N E2_N;
       G1_N G2_N G3_N E1_N E2_N;
       G1_N G2_N 0 E1_N E2_N;
       G1_N G2_N G3_N E1_N E2_N;
       G1_N G2_N G3_N 0 0];

P_m = zeros(size(P_N));
DP_m_ex = zeros(size(P_N));

%% Computation
P_0_init = zeros(size(P_0));
P_c0_cc = zeros(length(DP_c),1);
DP_m_tot = zeros(length(DP_c),1);
beta = zeros(length(DP_c),1);
DP_m = zeros(size(P_N));
P_m = zeros(size(P_N));
p_mi = zeros(size(P_N));
flag = 0;
while P_0_init(1) ~= P_0(1)
    if flag==0
        [DP_m(1,:), P_m(1,:)] = Calc_P_m_init(D(1), f_n, sigma, P_N(1,:), P_0, P_c0, DP_c(1));
        P_0 = P_m(1,:);
        DP_c(5) = P_0(3);
        DP_c(7) = -P_306313-P_310311+P_0(4)+P_0(5)-400;
        flag = 1;
    else
        P_0_init = P_0;
        [DP_m(2:end,:), P_m(2:end,:)] = Calc_new_P_m(D(2:end), f_n, sigma, P_N((2:end),:), P_0, P_c0, DP_c(2:end));
        for i=1:length(DP_c)
            DP_m_tot(i) = sum(DP_m(i,:));
            p_mi(i,:) = DP_m(i,:)/DP_m_tot(i); 
        end
    end
    
end
TYPE = {'BUSPART';'BUSPART';'BUSPART';'BUSPART';'BUSPART'};
ZONE = {'PRIM';'PRIM';'PRIM';'PRIM';'PRIM'};
BUS = name_Part_Bus;
for j=1:length(DP_c)
    PARTP = p_mi(j,:)';
    PARTQ = [1.,1.,1.,1.,1.]';
    DELIM = {';';';';';';';';';'};
    T = table(TYPE, ZONE, BUS, PARTP, PARTQ, DELIM);
    name = sprintf('BUS_PART%d.txt',j);
    writetable(T, name,'Delimiter',' ')
end