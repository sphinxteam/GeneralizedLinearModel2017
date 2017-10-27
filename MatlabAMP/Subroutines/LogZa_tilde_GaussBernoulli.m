function [ LogZ ] = LogZa_tilde_GaussBernoulli(Delta,V,y,w)

LogZ= - 0.5 * sqrt(2*pi*(Delta+V)) - 0.5*(( ((y-w).^2)./(Delta+V))); 


end
