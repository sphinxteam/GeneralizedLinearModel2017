function [ sqrt_var_phi ] = learn_sqrt_var_phi_gauss(U,V,var_psi,var_phi,rho,av_phi)

tho=(1-rho).*(var_psi.*U+1).^(-1/2).*exp( (V.^2)./(2.*(U+1./var_psi)) - ((V+av_phi./var_phi).^2)./(2.*(U+1./var_phi)) ) + rho.*(var_phi.*U+1).^(-1/2).*exp( -(av_phi.^2)./(2.*var_phi) );

up=(U+1./var_phi).^(-1/2) * ( ( av_phi.^2-2.*av_phi.*((V+av_phi./var_phi)./(U+1./var_phi))+(((V+av_phi./var_phi)./(U+1./var_phi)).^2)+(U+1./var_phi).^(-1) ).*tho.^(-1) )';

down=(U+1./var_phi).^(-1/2) * (tho.^(-1))';

var_phi=up./down;

sqrt_var_phi=sqrt(var_phi);


end

