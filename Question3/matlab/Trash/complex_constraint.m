function [c, ceq] = complex_constraint(x)
global Y0 eta N P_inj P_load Q_load P_gen Vnom Q_min Q_max
%SIMPLE_CONSTRAINT Nonlinear inequality constraints.
%x(1,1:28) = Voltage
%x(2,1:28) = Angle
%x(3,1:28) = Active power injected in network from bus
%x(4,1:28) = Reactive power injected in network from bus
%x(5,1:28) = Active power generated at bus
%x(6,1:28) = Reactive generated at bus
%   Copyright 2005-2007 The MathWorks, Inc.

c = [
%     -x(5,1) + x(3,1) + P_load(1);
%     -x(5,2) + x(3,2) + P_load(2);
%     -x(5,3) + x(3,3) + P_load(3);
%     -x(5,4) + x(3,4) + P_load(4);
%     -x(5,5) + x(3,5) + P_load(5);
%     -x(5,6) + x(3,6) + P_load(6);
%     -x(5,7) + x(3,7) + P_load(7);
%     -x(5,8) + x(3,8) + P_load(8);
%     -x(5,9) + x(3,9) + P_load(9);
%     -x(5,10) + x(3,10) + P_load(10);
%     -x(5,11) + x(3,11) + P_load(11);
%     -x(5,12) + x(3,12) + P_load(12);
%     -x(5,13) + x(3,13) + P_load(13);
%     -x(5,14) + x(3,14) + P_load(14);
%     -x(5,15) + x(3,15) + P_load(15);
%     -x(5,16) + x(3,16) + P_load(16);
%     -x(5,17) + x(3,17) + P_load(17);
%     -x(5,18) + x(3,18) + P_load(18);
%     -x(5,19) + x(3,19) + P_load(19);
%     -x(5,20) + x(3,20) + P_load(20);
%     -x(5,21) + x(3,21) + P_load(21);
%     -x(5,22) + x(3,22) + P_load(22);
%     -x(5,23) + x(3,23) + P_load(23);
%     -x(5,24) + x(3,24) + P_load(24);
%     -x(5,25) + x(3,25) + P_load(25);
%     -x(5,26) + x(3,26) + P_load(26);
%     -x(5,27) + x(3,27) + P_load(27);
%     -x(5,28) + x(3,28) + P_load(28);
    %%%
    %%% Reactive Power
    -x(6,1) + x(4,1) + Q_load(1);
    -x(6,2) + x(4,2) + Q_load(2);
    -x(6,3) + x(4,3) + Q_load(3);
    -x(6,4) + x(4,4) + Q_load(4);
    -x(6,5) + x(4,5) + Q_load(5);
    -x(6,6) + x(4,6) + Q_load(6);
%     -x(6,7) + x(4,7) + Q_load(7);
%     -x(6,8) + x(4,8) + Q_load(8);
%     -x(6,9) + x(4,9) + Q_load(9);
%     -x(6,10) + x(4,10) + Q_load(10);
%     -x(6,11) + x(4,11) + Q_load(11);
%     -x(6,12) + x(4,12) + Q_load(12);
%     -x(6,13) + x(4,13) + Q_load(13);
%     -x(6,14) + x(4,14) + Q_load(14);
%     -x(6,15) + x(4,15) + Q_load(15);
%     -x(6,16) + x(4,16) + Q_load(16);
%     -x(6,17) + x(4,17) + Q_load(17);
%     -x(6,18) + x(4,18) + Q_load(18);
%     -x(6,19) + x(4,19) + Q_load(19);
%     -x(6,20) + x(4,20) + Q_load(20);
%     -x(6,21) + x(4,21) + Q_load(21);
%     -x(6,22) + x(4,22) + Q_load(22);
%     -x(6,23) + x(4,23) + Q_load(23);
%     -x(6,24) + x(4,24) + Q_load(24);
%     -x(6,25) + x(4,25) + Q_load(25);
    -x(6,26) + x(4,26) + Q_load(26);
    -x(6,27) + x(4,27) + Q_load(27);
    -x(6,28) + x(4,28) + Q_load(28);
     x(6,1) - Q_max(1);
     x(6,2) - Q_max(2);
     x(6,3) - Q_max(3);
     x(6,4) - Q_max(4);
     x(6,5) - Q_max(5);
     x(6,6) - Q_max(6);
     Q_min(1) - x(6,1);
     Q_min(2) - x(6,2);
     Q_min(3) - x(6,3);
     Q_min(4) - x(6,4);
     Q_min(5) - x(6,5);
     Q_min(6) - x(6,6);
%      x(1,3) - Vnom(3)*1.01;
%      x(1,4) - Vnom(4)*1.01;
%      x(1,5) - Vnom(5)*1.01;
%      x(1,6) - Vnom(6)*1.01;
%      x(1,26) - Vnom(26)*1.01;
%      x(1,27) - Vnom(27)*1.01;
%      x(1,28) - Vnom(28)*1.01;
%      -x(1,3) + Vnom(3)*0.99;
%      -x(1,4) + Vnom(4)*0.99;
%      -x(1,5) + Vnom(5)*0.99;
%      -x(1,6) + Vnom(6)*0.99;
%      -x(1,26) + Vnom(26)*0.99;
%      -x(1,27) + Vnom(27)*0.99;
%      -x(1,28) + Vnom(28)*0.99;
];
% No nonlinear equality constraints:
for i=1:28
    j = i;
    ceq(i) = x(3,j) - sum(abs(Y0(j,:)).*(cosd(eta(j,:)).*x(1,j)^2 - x(1,j).*x(1,:)./N(j,:) .* cosd(x(2,j) - x(2,:) - eta(j,:))));
end
for i=29:56
    j = i-28;
    ceq(i) = x(4,j) - sum(abs(Y0(j,:)).*(-sind(eta(j,:)).*x(1,j)^2 - x(1,j).*x(1,:)./N(j,:) .* sind(x(2,j) - x(2,:) - eta(j,:))));
end
for i=57:84
    j = i - 56;
    if j ~= 26
        ceq(i) = x(3,j) - P_inj(j);
    else
        ceq(i) = x(2,j) - 0;
    end
end
for i=85:112
    j = i - 84;
    ceq(i) = -x(5,j) + x(3,j) + P_load(j);
end

for i=113:136
    j = i - 112;
    ceq(i) = -x(6,j) + x(4,j) + Q_load(j);
end
for i=137:156
    if (2 < j) && (j <= 6) 
        ceq(i) = x(1,j) - Vnom(j);
    elseif j >= 26
        ceq(i) = x(1,j) - Vnom(j);
    end
end
ceq(157) = x(1,14) - 1.04;
