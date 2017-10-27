function [A B] = ComputeMarginals(S2,R,rho,mean_,variance_,TYPE);
    F_a_new=f_a_GaussBernoulli(S2,R,rho,mean_,variance_);
    F_b_new=f_b_GaussBernoulli(S2,R,rho,mean_,variance_);
end

