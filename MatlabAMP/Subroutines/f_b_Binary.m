function [ F_b_ ] = f_b_Binary(S2,R,rho,a,b)

F_a_=rho./(rho+(1-rho)*exp((1-2*R)./(2*S2)));
F_b_=F_a_.*(1-F_a_);

    
end
