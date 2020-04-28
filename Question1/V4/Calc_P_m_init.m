function [DP_m, P_m, P_gen] = Calc_P_m_init(D, f_n, sigma, P_N, P_0, PG_0, P_c0, DP_c)
    beta = D * P_c0 + 1/f_n * sum(P_N(:))/sigma;
    DP_m(:) = DP_c .* P_N(:)./(f_n*beta*sigma);
    P_m = P_0 + DP_m;
    P_gen = [P_m(1:3) PG_0(4:end) P_m(4:5)];
end
