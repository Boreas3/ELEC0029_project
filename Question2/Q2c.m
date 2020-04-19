%% Données

% Transfo T306 - B313

S_tfo = 1350; % MVA
X_tfo = 0.1; % pu
V_b = 380; % kV
Z_b = V_b^2/S_tfo;

phi = 0:1:90;

P = 1/X_tfo .* sind(phi) *S_tfo

% Line L306 - 313

R_line = 1.2560;
X_line = 13.992;
wc_line = 80.125;
S_line = 1350;
I_max = S_line/(sqrt(3)*V_b);
P_max = sqrt(3) * V_b * I_max; 

