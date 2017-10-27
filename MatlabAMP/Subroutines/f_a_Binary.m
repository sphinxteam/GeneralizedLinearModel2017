function [ F_a_obtained ] = f_a_Binary(S2,R,rho,a,b)

F_a_obtained=rho./(rho+(1-rho)*exp((1-2*R)./(2*S2)));
    
end
