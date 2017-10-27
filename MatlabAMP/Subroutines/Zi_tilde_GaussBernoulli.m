function [ Z ] = Zi_tilde_GaussBernoulli(S2,R,rho)

Z=(1-rho)+rho*sqrt(2*pi.*S2).*exp(R.^2./(2*S2));

end

