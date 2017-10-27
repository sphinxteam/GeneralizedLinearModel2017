function [f_a] = f_a_2Gauss(X,Y,rho,av_phi,var_phi,var_psi)

p_1=(Y./(X+var_psi.^(-1))).*(1-rho).*(var_psi.*X+1).^(-1/2).*exp(-( ((Y+av_phi./var_phi).^2)./(2.*(X+var_phi.^(-1)))-(av_phi.^2)./(2.*var_phi) - ( (Y.^2)./(2.*(X+var_psi.^(-1))) )));
p_2=((Y+av_phi./var_phi)./(X+var_phi.^(-1))).*rho.*(var_phi.*X+1).^(-1/2);
p_3=(1-rho).*(var_psi.*X+1).^(-1/2).*exp(-( ((Y+av_phi./var_phi).^2)./(2.*(X+var_phi.^(-1)))-(av_phi.^2)./(2.*var_phi) - ( (Y.^2)./(2.*(X+var_psi.^(-1))) )));
p_4=rho.*(var_phi.*X+1).^(-1/2);

f_a=(p_1+p_2).*(p_3+p_4).^(-1);

end

