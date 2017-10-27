function [ exp_gauss_new ] = learn_expectation_gauss(A,size,rho)
% (39) in the long version
% Learning of the expectation value of the gaussian used in the probability
% exp_gauss_new : new expectation value of the gaussian used in the probability
% size : number of components of the original signal
% rho : fraction of non zero components of the original signal
% A : vector of the averages of the reconstructed signal components, (24)
% in the long version

exp_gauss_new=(size.*rho).^(-1)*sum(A);


end

