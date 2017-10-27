function [ LogZ ] = LogZi_star_GaussBernoulli(S2,R,rho,x_av,x2_av,y,w,V,delta,N)

LogZ= -rho*( -x2_av ./(2*S2)  + x_av .* (R./S2) - (x2_av./N).*(sum( ((y-w).^2)./(delta+V).^2)));

end

