function [f_b] = f_b_2Gauss(X,Y,rho,av_phi,var_phi,var_psi)

a=(Y./(X+var_psi.^(-1))).^2;
b=(X+var_psi.^(-1)).^(-1);
c=(var_psi.*X+1).^(-1/2);
d=((Y+av_phi./var_phi)./(X+var_phi.^(-1))).^2;
e=(X+var_phi.^(-1)).^(-1);
f=(var_phi.*X+1).^(-1/2);
tho=(1-rho).*(var_psi.*X+1).^(-1/2).*exp( (Y.^2)./(2.*(X+1./var_psi)) - ((Y+av_phi./var_phi).^2)./(2.*(X+1./var_phi)) ) + rho.*(var_phi.*X+1).^(-1/2).*exp( -(av_phi.^2)./(2.*var_phi) );

up=exp( 2.*( (Y.^2)./(2.*(X+var_psi.^(-1))) - ((Y+av_phi./var_phi).^2)./(2.*(X+var_phi.^(-1)))  ) ).*b.*c.^2.*(1-rho).^2 + exp(-(av_phi.^2)./var_phi).*e.*f.^2.*rho.^2 + exp( (Y.^2)./(2.*(X+var_psi.^(-1))) - ((Y+av_phi./var_phi).^2)./(2.*(X+var_phi.^(-1))) - (av_phi.^2)./(2.*var_phi) ).*rho.*(1-rho).*f.*c.*(b+e+(sqrt(a)-sqrt(d)).^2);

f_b=up./(tho.^2);

end

