function [ F_a_obtained ] = f_a_GaussBernoulli(S2,R,rho,m,s2)

Z=(1-rho)*exp(-R.*R./(2*S2))+rho*sqrt(S2./(S2+s2)).*exp(-((R-m).^2)./(2*(S2+s2)));

UP=rho*exp(-((R-m).^2)./(2*(S2+s2))).*(sqrt(S2)./(S2+s2).^(1.5)).*(m*S2+R*s2);

F_a_obtained=UP./Z;
    
end

