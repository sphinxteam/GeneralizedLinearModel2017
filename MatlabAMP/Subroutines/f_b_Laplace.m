function [ F_c ] = f_b_Laplace(S2_,R_,rho,m,s2)
    beta_=1;
    erfc_p = erfc((R_ + beta_ .* S2_) ./ sqrt(2 .* S2_) );
    erfc_m = erfc((-R_ + beta_ .* S2_) ./ sqrt(2 .* S2_) );
    z = erfc_p + erfc_m .* exp(-2 .* beta_ .* R_);
    F_a = ((R_ + beta_ .* S2_) .* erfc_p + (R_ - beta_ .* S2_) .* erfc_m .* exp(-2 .* beta_ .* R_) ) ./ z;    

    f_b_part1 = -4 .* beta_ .* S2_.^(3 ./ 2) ./ (sqrt(2 .* pi) .* (exp((beta_ .* S2_ + R_).^2 ./ (2 .* S2_) ) .* erfc_p + exp((beta_ .* S2_ - R_).^2 ./ (2 .* S2_) ) .* erfc_m) );
    f_b_part2 = (((R_ + beta_ .* S2_).^2 + S2_) .* erfc_p + ((R_ - beta_ .* S2_).^2 + S2_) .* erfc_m .* exp(-2 .* beta_ .* R_) ) ./ z;

    F_c = max(f_b_part1 + f_b_part2 - F_a.^2,(1e-10).*ones(size(F_a)));

end

