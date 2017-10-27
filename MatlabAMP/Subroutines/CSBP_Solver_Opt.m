% EMBP_partial_Opt  
% Function to set EMBP_Solver_Opt to their default values
%
%    Details of the option:
%   .nb_iter            max number of iterations [default : 1000]
%   .verbose_n          print results every n iteration (0 -> never) [10]
%   .conv_criterion     convergence criterion [10^(-8)]
%   .learning_param     learning parameters or not [0]
%   .signal_mean        first estimate of the mean of the Gaussian [0]
%   .signal_var         first estimate of the variance of the Gaussian [1]
%   .signal_rho         first estimate of the density of the signal [M/10N]
%   .var_noise          first estimate of the variance vector of the noise [1E-10]
%   .signal             a solution to compare to while running
%   .damp_learn         damping coefficient of the learning [0.5]
%   .damp_mes           damping of the messages [0.5]
%   .prior              prior on the data [GaussBernoulli]
%                       One can use 'GaussBernoulli', 'Binary' and
%                       also 'Approx' for approximate-sparsity
%   .approx             If 1, allows to use approximate sparsity (with the
%                       prior 'Approx') [0]
%   .var_approx         Default values of the variance of the small
%                       components in case of approximate sparsity
%                       [0]             
%   .option_noise       Value is Active/None [None]. If activated,
%                       it deals with matrix uncertainty
%   .remove_mean        [0] When activited (1 instead of 0), this
%                       allows the algortimh to deal with non zero
%                       mean matrices. With value 2 it uses ana
%                       average value. If provided (see bellow), it
%                       uses the one given by the user.
%   .Gmean              see .remove_mean
%   .Ymean              see .remove_mean
%   .Nvec               [1] This can be used to specify a structure
%                       to the signal, and change the printing
%                       output
%   .Mvec               [1] This can be used to specify a structure
%                       to the solution vector Y (this is used in
%                       Active option.noise for instance)

function opt = CSBP_Solver_Opt()
       opt.nb_iter=1000;
       opt.verbose_n=10;
       opt.conv_criterion =10^(-6);
       opt.learning_param=1;
       opt.signal_mean=0;
       opt.signal_var=1;
       opt.signal_rho=-1; %This means alpha/10 will be used!
       opt.var_noise=10^(-10);
       opt.signal=[];
       opt.damp_learn=0.5;
       opt.damp_mes=0.5;
       opt.prior='GaussBernoulli';
       opt.approx=0;
       opt.var_approx=0;
       opt.option_noise='None';
       opt.remove_mean=0;
       opt.Gmean=[];
       opt.Ymean=[];
       opt.Nvec=[1];
       opt.Mvec=[1];
end