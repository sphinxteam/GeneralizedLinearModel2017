function [ LogZ ] = LogZi_tilde_GaussBernoulli(S2,R,rho)

%Z=(1-rho)+rho*sqrt(2*pi.*S2).*exp(R.^2./(2*S2));
LogZ = log ( (1-rho)*exp(-R.^2./(2*S2))+rho.*sqrt(2*pi.*S2)) + 0.5 * R.^2./S2;
end

