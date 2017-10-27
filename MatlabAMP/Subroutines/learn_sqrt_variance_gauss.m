function [ sqrt_var_gauss_new ] = learn_sqrt_variance_gauss(A,B,size,rho,exp_gauss)
% Learning rule of the sqrt(variance) of the gaussian in the probability measure
% size : number of components of the measured signal
% A : vector of the averages of the reconstructed signal components, (24)
% in the long version
% B : vector of the variances of the reconstructed signal components, (25)
% in the long version

sqrt_var_gauss_new=sqrt(max(0,((size.*rho).^(-1)*sum(A.^2+B)-exp_gauss.^2)));



end

