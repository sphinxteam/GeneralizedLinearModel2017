function [ F_a_obtained ] = f_a_BinaryZERO(S2,R,rho,a,b)

Z=0.5*rho*exp(-((R+1).^2)./(2.*S2))+0.5*rho*exp(-((R-1).^2)./(2.*S2))+(1-rho)*exp(-(R.^2)./(2.*S2));

PMINUS=0.5*rho*exp(-((R+1).^2)./(2.*S2))./Z;
PPLUS=0.5*rho*exp(-((R-1).^2)./(2.*S2))./Z;
PZEROS=(1-rho)*exp(-(R.^2)./(2.*S2))./Z;

F_a_obtained=PPLUS-PMINUS;
    
end
