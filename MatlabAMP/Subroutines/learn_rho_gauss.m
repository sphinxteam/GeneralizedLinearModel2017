function [ rho_new ] = learn_rho_gauss(U,V,F_a,var_psi,var_phi,rho,av_phi)

if (rho ==1)
    rho=0.99999999;
end

tho=(1-rho).*(var_psi.*U+1).^(-1/2).*exp( (V.^2)./(2.*(U+1./var_psi)) - ((V+av_phi./var_phi).^2)./(2.*(U+1./var_phi)) ) + rho.*(var_phi.*U+1).^(-1/2).*exp( -(av_phi.^2)./(2.*var_phi) );

% up=((U+1./var_phi)./(V+av_phi./var_phi)) * (F_a- ( (V./(U+1./var_psi)).*(1-rho).*(var_psi.*U+1).^(-1/2).*exp( (V.^2)./(2.*(U+1./var_psi)) - ((V+av_phi./var_phi).^2)./(2.*(U+1./var_phi)) ) ).*tho.^(-1))';
% 
% down=((U+1./var_psi)./(V.*(1-rho))) * (F_a- ( ((V+av_phi./var_phi)./(U+1./var_phi)).*rho.*(var_phi.*U+1).^(-1/2).*exp( -(av_phi.^2)./(2.*var_phi) ) ).*tho.^(-1))';
% 
% rho_new=up./down;

up=(rho.*exp( -(av_phi.^2)./(2.*var_phi) )./(sqrt(var_phi.*U+1))) * (tho.^(-1))';

down=(exp( (V.^2)./(2.*(U+1./var_psi)) - ((V+av_phi./var_phi).^2)./(2.*(U+1./var_phi)) )./(sqrt(var_psi.*U+1))) * (tho.^(-1))';

rho_new=up./down;


end

