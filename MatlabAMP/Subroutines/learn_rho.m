function [ rho_new ] = learn_rho(U,V,exp_gauss,sqrt_var_gauss,A,rho_old,alpha)
% (38) in the long version
% U : (49) in the long version
% V : (50) in the long version
% rho_old : previous fraction of non zero components of the original signal
% rho_new : new fraction of non zero components of the original signal
% exp_gauss : expectation of the gaussian taken in the probability measure
% sqrt_var_gauss : it's mean displacement


q=sum((sqrt_var_gauss.^(-2)+U).*A./(V+exp_gauss.*sqrt_var_gauss.^(-2)));

w=sum((1-rho_old+rho_old./(sqrt_var_gauss.*sqrt(U+sqrt_var_gauss.^(-2))).*exp(((V+exp_gauss.*sqrt_var_gauss.^(-2)).^2)./(2.*(sqrt_var_gauss.^(-2)+U))-(exp_gauss.^2)./(2.*sqrt_var_gauss.^2))).^(-1));

rho_new=q./w;

if (rho_new<=0)  % rho cannot be negative
    rho_new=10.^(-10);
end

if (rho_new>alpha)  % rho must stay less than alpha
    rho_new=alpha;
end

end

