function [ F_a_obtained ] = SOL_BinaryZERO(S2,R,rho,a,b)

   size(R)
   size(S2)

    Z=0.5*rho*exp(-((R+1).^2)./(2.*S2))+0.5*rho*exp(-((R-1).^2)./(2.*S2))+(1-rho)*exp(-(R.^2)./(2.*S2));
    
    PMINUS=0.5*rho*exp(-((R+1).^2)./(2.*S2))./Z;
    PPLUS=0.5*rho*exp(-((R-1).^2)./(2.*S2))./Z;
    PZEROS=(1-rho)*exp(-(R.^2)./(2.*S2))./Z;
    

    check_zero=PZEROS>max(PPLUS,PMINUS);
    F_a_obtained=(2*(PPLUS>PMINUS)-1).*(1.-check_zero);
    
end
