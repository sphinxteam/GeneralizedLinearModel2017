function [var_noise_new] = learn_variance_noise(var_noise_old,Y,W,GAMMA)

var_noise_new=sum(((Y-W)./(1+GAMMA./var_noise_old)).^2)./(sum((1+GAMMA./var_noise_old).^(-1)));

end

