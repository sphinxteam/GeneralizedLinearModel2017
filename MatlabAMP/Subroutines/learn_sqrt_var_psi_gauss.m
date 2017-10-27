function [sqrt_var_psi] = learn_sqrt_var_psi_gauss(U,V,var_psi,var_phi,rho,av_phi)

if (var_psi == 0)
    var_psi=1E-50;
end

tho=(1-rho).*(var_psi.*U+1).^(-1/2).*exp( (V.^2)./(2.*(U+1./var_psi)) - ((V+av_phi./var_phi).^2)./(2.*(U+1./var_phi)) ) + rho.*(var_phi.*U+1).^(-1/2).*exp( -(av_phi.^2)./(2.*var_phi) );

up=( (U+1./var_psi).^(-1/2).*exp( (V.^2)./(2.*(U+1./var_psi)) - ((V+av_phi./var_phi).^2)./(2.*(U+1./var_phi)) ).*( ((V./(U+1./var_psi)).^2)+(U+1./var_psi).^(-1)) ) * (tho.^(-1))';  

down=( (U+1./var_psi).^(-1/2).*exp( (V.^2)./(2.*(U+1./var_psi)) - ((V+av_phi./var_phi).^2)./(2.*(U+1./var_phi)) ) ) * (tho.^(-1))';

var_psi=up./down;

sqrt_var_psi=sqrt(var_psi);

end

