function [ F_b_obtained ] = f_b_newform(S2,R,rho,m,s2)


Z=(1-rho)*exp(-R.*R./(2*S2))+rho*sqrt(S2./(S2+s2)).*exp(-((R-m).^2)./(2*(S2+s2)));

UP=rho*(1-rho)*exp(-R.*R./(2*S2) -((R-m).^2)./(2*(S2+s2))).*(sqrt(S2)./(S2+s2).^(2.5)).*(s2.*S2.*(S2+s2)+(m*S2+R*s2).^2)+rho*rho*exp(-((R-m).^2)./((S2+s2))).*(s2*S2.^2)./(s2+S2).^2;

F_b_obtained=UP./Z.^2;
end

