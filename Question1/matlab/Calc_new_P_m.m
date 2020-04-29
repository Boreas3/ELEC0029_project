%%%
% There are two main equations
% beta(i) = DPc0 + 1/f_n * sum(P_N(i,:))/sigma; 
% with Pc0 being the initial total active power consumed in the network. This value remains unchanged
% DP_m(i,:) = DP_c(i) .* P_N(i,:)./(f_n*beta(i)*sigma);
% with DP_c(i) being the variation of the active power consumption in the
% network. We will supposed that if one generator is lost, the "lost power"
% will be taken as an extra load
%%%

function [DP_m, P_m, P_gen] = Calc_new_P_m(D, f_n, sigma, P_N, P_0, P_G, P_c0, P_load, DP_c)
    o = zeros(length(P_N(1,:)), 1) + 1;
    beta = zeros(length(DP_c),1);
    DP_m = zeros(size(P_N));
    P_m = zeros(size(P_N));
    beta_new = zeros(size(beta));
    DP_c_new = zeros(size(DP_c));
    
    Name = {'G1','G2','G3','E1','E2'};
    
    
    P_N_new = zeros(size(P_N));

    
    for i=1:length(DP_c)
        flag=0;
        DP_c(i) = DP_c(i) + (P_load(i) - P_c0);
        beta(i) = D(i) * P_c0 + 1/f_n * sum(P_N(i,:))/sigma;
        DP_m(i,:) = DP_c(i) .* P_N(i,:)./(f_n*beta(i)*sigma);
        P_m(i,:) = P_0 + DP_m(i,:);
        
        P_N_new(i,:) = P_N(i,:);
        beta_new(i) = beta(i);
        DP_c_new(i) = DP_c(i);
        P_N_order = containers.Map(Name, P_N(i,:));
        keys = P_N_order.keys;
        values = cell2mat(P_N_order.values);
        [~, sortIdx] = sort( values );
        % Case 1: P_m(j) <  P_N(j) --> OK
        % Case 2: P_m(j) >= P_N(j) --> KO
        for k=1:length(keys)
            j = sortIdx(k);
            if P_N(i,j)==0
                P_m(i,j) = 0;
            end
            if P_m(i,j) > P_N(i,j) && P_N(i,j) > 0
                o(j) = 0;
                P_m(i,j) = P_N_new(i,j);
                P_N_new(i,j) = 0;
                DP_m(i,j) = P_m(i,j) - P_0(j);
                DP_c_new(i) = DP_c_new(i) - DP_m(i,j);
            end  
            beta_new(i) = D(i) * P_c0 + 1/f_n * sum(P_N_new(i,:))/sigma;
            for j=1:length(P_N(1,:))
                if o(j) == 1
                    DP_m(i,j) = DP_c_new(i) .* P_N_new(i,j)./(f_n*beta_new(i)*sigma);
                end
                P_m(i,j) = P_0(j) + DP_m(i,j);
                if P_N(i,j)==0
                     P_m(i,j) = 0;
                end
            end
        end
        
        o = zeros(length(P_N(1,:)), 1) + 1; 
        P_G_temp = P_G(i, 4:end);
       
        P_gen(i,:) = [P_m(i,1:3) P_G_temp P_m(i,4:5)];
    end
end