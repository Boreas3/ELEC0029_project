clear all
warning('off','MATLAB:xlswrite:AddSheet'); %optional
%% Données
%%
% Cas 1: All OK
% Cas 1a: trip L310-311
% Cas 1b: trip L306-313
% Cas 1c: trip G5

% Network


sigma = 0.05;
D = zeros(7,1) + 0.001; %1/Hz
f_n = 50; % Hz

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
PG_0 = [G1_0 G2_0 G3_0 G4_0 G5_0 G6_0];
P_0 = [G1_0 G2_0 G3_0 E1_0 E2_0];
P_c0 = G1_0+G2_0+G3_0+G4_0+G5_0+G6_0+E1_0+E2_0+E3_0; % MW
P_c0_cc = 3346.6;
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
name_Part_Bus = {'G1'; 'G2'; 'G3'; 'E1'; 'E2'};
name_Bus = {'G1'; 'G2'; 'G3'; 'G4'; 'G5'; 'G6'};
sl = P_c0_cc - P_c0;
DP_c = zeros(7,1);
DP_c(1)=sl;
P_N = [G1_N G2_N G3_N E1_N E2_N;
       G1_N G2_N G3_N E1_N E2_N;
       G1_N G2_N G3_N E1_N E2_N;
       G1_N G2_N G3_N E1_N E2_N;
       G1_N G2_N 0 E1_N E2_N;
       G1_N G2_N G3_N E1_N E2_N;
       G1_N G2_N G3_N 0 0];

%% Computation
DP_m_tot = zeros(length(DP_c),1);
beta = zeros(length(DP_c),1);
DP_m = zeros(size(P_N));
P_m = zeros(size(P_N));
p_mi = zeros(size(P_N));
P_gen = zeros(length(DP_c), length(PG_0));
flag = 0;
%%%%
[DP_m(1,:), P_m(1,:), P_gen(1,:)] = Calc_P_m_init(D(1), f_n, sigma, P_N(1,:), P_0, PG_0, P_c0, DP_c(1));
P_0 = P_m(1,:);
P_0(1) = 754.8;
DP_c(2:end) = [0 0 G5_0 P_0(3) G6_0 P_0(4)+P_0(5)-400];
[DP_m(2:end,:), P_m(2:end,:), P_gen(2:end,:)] = Calc_new_P_m(D(2:end), f_n, sigma, P_N((2:end),:), P_0, PG_0, P_c0_cc, DP_c(2:end));
for i=1:length(DP_c)
    DP_m_tot(i) = sum(DP_m(i,:));
    if DP_m_tot(i) == 0
        p_mi(i,:) = p_mi(i-1,:);
    else
        p_mi(i,:) = DP_m(i,:)/DP_m_tot(i); 
    end
end
%%%%
TYPE = {'BUSPART';'BUSPART';'BUSPART';'BUSPART';'BUSPART'};
ZONE = {'PRIM';'PRIM';'PRIM';'PRIM';'PRIM'};
BUS = name_Part_Bus;
EVENT = {'No perturbation';'tripping B310-B311';'tripping B306-B313';'tripping G5';'tripping G3';'tripping G6';'tripping B310-B311+B306-B313'};
for i=1:length(DP_c)
    PARTP = p_mi(i,:)';
    PARTQ = [1.,1.,1.,1.,1.]';
    DELIM = {';';';';';';';';';'};
    T_PRIM = table(TYPE, ZONE, BUS, PARTP, PARTQ, DELIM);
    writetable(T_PRIM,'Event.xlsx','Sheet',string(EVENT(i)), 'UseExcel', false);
%     name = string(EVENT(i));
%     xlswrite('Event.xlsx',T_PRIM,name);
    %writetable(T_PRIM, name,'Delimiter',' ')
end

POW_G1 = P_gen(:,1);
POW_G2 = P_gen(:,2);
POW_G3 = P_gen(:,3);
POW_G4 = P_gen(:,4);
POW_G5 = P_gen(:,5);
POW_G6 = P_gen(:,6);
T_POW = table(EVENT,POW_G1, POW_G2, POW_G3, POW_G4, POW_G5, POW_G6);
writetable(T_POW, 'Generator power.xlsx', 'UseExcel', false);