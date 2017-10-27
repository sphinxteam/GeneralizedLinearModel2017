function [ F_a_obtained ] = f_c_PM(S2,R,rho,a,b)
    F_a_obtained=max(1-(tanh(R./S2)).^2,0);
end
