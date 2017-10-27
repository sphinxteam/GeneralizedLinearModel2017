function [ F_a ] = f_a_Laplace(S2_,R_,rho,m,s2)
    beta_=1;
    erfc_p = erfc((R_ + beta_ .* S2_) ./ sqrt(2 .* S2_) );
    erfc_m = erfc((-R_ + beta_ .* S2_) ./ sqrt(2 .* S2_) );
    z = erfc_p + erfc_m .* exp(-2 .* beta_ .* R_);
    F_a = ((R_ + beta_ .* S2_) .* erfc_p + (R_ - beta_ .* S2_) .* erfc_m .* exp(-2 .* beta_ .* R_) ) ./ z;    
end

