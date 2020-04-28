%% data

% Loads

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

Inc = [1.05 1.1 1.15 1.2 1.25 1.3];

for i=1:length(Inc)
    P_inc(i,:) = Inc(i) * P;
    deltaP(i,:) = P_inc(i,:) - P;
    %P_tot_inc(i) = sum(P_inc(i,:));
    %f_P_inc(i,:) = P_inc(i,:)/P_tot_inc(i);
    Q_inc(i,:) = P_inc(i,:) .* tan(phi);
    deltaQ(i,:) = Q_inc(i,:) - Q;
    PQ_inc(:,2*i-1) = transpose(P_inc(i,:));
    PQ_inc(:,2*i) = transpose(Q_inc(i,:));
    deltaPQ(:,2*i-1) =  transpose(deltaP(i,:));
    deltaPQ(:,2*i) = transpose(deltaQ(i,:));
end




