function [ F_a_obtained ] = Fun_Final(S2,R,rho,m,s2)

    
Zzer=    (1-rho)*exp(-R.*R./(2*S2));
Z=(1-rho)*exp(-R.*R./(2*S2))+rho*sqrt(S2./(S2+s2)).*exp(-((R-m).^2)./(2*(S2+s2)));

PZER=1-(Zzer./Z>0.499999999);

UP=exp(-((R-m).^2)./(2*(S2+s2))).*(sqrt(S2)./(S2+s2).^(1.5)).*(m*S2+R*s2);

DOWN=sqrt(S2./(S2+s2)).*exp(-((R-m).^2)./(2*(S2+s2)));

F_a_obtained=(UP./DOWN).*PZER;
    
end

