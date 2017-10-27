function [S] = BiGauss(size,rho,av_phi,var_phi,var_psi)
% Create an homogeneous random Bi Gaussian vector with rho as fraction
% of big components, var_phi as expectation for this gaussian and
% var_phi for it's variance. var_psi is the variance of the small
% components of the produced signal.
% size is the number of components of the original signal

num_non_zero=floor(rho*size);
num_zero=size-num_non_zero;

S=([randn(1,num_zero).*sqrt(var_psi),randn(1,num_non_zero).*sqrt(var_phi)+av_phi]);
%S=(intrlv(SS,randperm(size)));

end




