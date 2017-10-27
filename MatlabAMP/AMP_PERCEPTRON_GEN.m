% AMP is a Belief-Propagation based solver for compressed
% sensing.
% Given an (underdetermined) system y = Gx + noise, AMP will
% return a signal estimate x of length N given the mSWeasurements y of
% length M and the matrix G.  It uses a Gauss-Bernoulli factorized
% prior (Binary prior and Approximately sparse priors are also
% possible). 
%
% SYNTAX :
% [X, mean, variance, rho, var_noise] = AMP(Y, G, opt)
%
% Inputs :
% Y                     M measurement vector (row or column)
% G                     M-by-N measurement matrix
% opt -    structure containing  option fields
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
%
% Outputs :
% X                     final signal estimate as a column vector
% mean                  estimated mean of the non zero component
% variance              estimated variance of the non zero component
% rho                   estimated density of non zero components
% var_noise             estimated variance vector of the noise
%
% Example:
% N=2000; alpha=0.7; rho_s=0.4; M=floor(N*alpha);
% S=gauss_bernoulli(N,rho_s,0,1)';
% F=randn(M,N)/sqrt(N);
% Y=F*S+randn(M,1)*10^(-6);
% [X, mean, variance, rho, var_noise] = SWAMP(Y, F);
% disp('Mean Square Error is:')
% disp(error_estimate(X,S))
%
% One can modify the option easily.
% For instance to remove the learning option and use the signal for
% comparaison, one can write
% Myopt=CSBP_Solver_Opt(); 
% Myopt.learning_param=0; Myopt.verbose_n=1;
% Myopt.signal=S;Myopt.signal_rho=rho_s;
% [X, mean, variance, rho, var_noise] = SWAMP(Y, F, Myopt);
%

function  [X, mean, variance, rho, var_noise, final_error] = AMP_PERCEPTRON_GEN(Y, G, opt)
    path(path,'./Subroutines');

    % Simple checks on the sizes of Y and G
    [M,N]=size(G);
    [a,b]=size(Y);
    alpha=M/N;
    
    
    % Reading parameters
    if (nargin <= 2)
        opt = CSBP_Solver_Opt(); % Use default  parameters
    end
    
    % Set parameters
    t_max=opt.nb_iter; % Maximum number of iterations
    affichage=opt.verbose_n; % Printing every n iteration (n=0 means no print)
    conv_criterion_t=opt.conv_criterion; % Accuracy required for the test of convergence in stability in time
    conv_criterion_acc=opt.conv_criterion; % Accuracy required for the reconstruction
    learn_param=opt.learning_param; % Learning of the parameters? If yes, learn_param=1, else learn_param~=1
    exp_gauss=opt.signal_mean; % Average of the gaussian
    sqrt_var_gauss=sqrt(opt.signal_var); % Sigma (that is sqrt(variance)) of the gaussian
    var_gauss=opt.signal_var;
    rho=opt.signal_rho; % Estimate of rho
    prior=opt.prior;% Prior, the default one is Gauss-Bernouilli
    approx_sparse=opt.approx;%Approximate Sparsity,  default value is 0;
    sqrt_var_approx=sqrt(opt.var_approx); % Sigma (that is sqrt(variance)) of the gaussian psi
    remove_mean=opt.remove_mean;
    Gmean=opt.Gmean;Ymean=opt.Ymean;
    Nvec=opt.Nvec;if (Nvec==1) Nvec=N;end;
    Mvec=opt.Mvec;if (Mvec==1) Mvec=M;end;
    
    if (rho < 0)
        rho=alpha/10;
    end
    var_noise=opt.var_noise; 
    S=opt.signal; % If the solution is known, this will allow test on the fly
    [a,b]=size(S);
    if (b > a)
        S=S';
    end
    damp_learn=opt.damp_learn;  % Damping coefficient of the learning
    damp_mes=opt.damp_mes;  % Damping of the messages
    
    % Initialisation 
    F_a=zeros(N,1);
    F_b=ones(N,1);
    R=zeros(N,1);
    S2=zeros(N,1);
    W=Y;
    V=((G.^2)*F_b);
    
    % Definition of the prior
    switch     prior
      case    {'GaussBernoulli'}  
        disp    (['Gauss-Bernoulli Prior'])
        Fun_a=@f_a_GaussBernoulli;Fun_b=@f_b_GaussBernoulli;
        Fun_solution=@f_a_GaussBernoulli;
      case    {'Binary'}  
        disp    (['Binary Prior'])
        Fun_a=@f_a_Binary;Fun_b=@f_b_Binary;
        learning_meanandvar=0;
      case    {'Approx'}  
        disp    (['Approxmitaly Sparse Gauss-Bernoulli Prior'])
        Fun_a=@f_a_2Gauss;Fun_b=@f_b_2Gauss;
      case    {'Laplace'}  
        disp    (['Laplace (non-sparse) Prior'])
        Fun_a=@f_a_Laplace;Fun_b=@f_b_Laplace;
      case    {'PM'}  
        disp    (['Plus/Minus (non-sparse rho=0.5) Prior'])
        Fun_a=@f_a_PM;Fun_b=@f_c_PM;
        Fun_solution=@SOL_PM;
      case    {'PMZ'}  
        disp    (['Plus/Minus/ZERO  Prior'])
        Fun_a=@f_a_BinaryZERO;Fun_b=@f_b_BinaryZERO;
        Fun_solution=@SOL_BinaryZERO;
      case    {'P3'}  
        disp    (['P=3 Prior'])
        Fun_a=@f_a_P3;Fun_b=@f_c_P3;
      otherwise
        disp    (['unknown prior'])
        return;
    end
    
    % Affichage, t=0
    if (affichage > 0)
        if (max(size(S)) < 2)
            disp('iter      convergence  damping')
        else
            disp(['iter     convergence damping Error'])
        end
    end
    
    %Starting code
    t=0;
    
    if (max(size(S)) > 2)
        solution=Fun_solution(S2,R,rho,exp_gauss,sqrt_var_gauss.^2);
        err_true=sum(abs(solution-S))/(2*N);
    end
    
    %Printing to screen
    if (affichage > 0)
        if (mod(t,affichage) == 0)
            PR=sprintf('%d %e %f',full([t  0 damp_mes]));
            if (~(max(size(S)) < 2))
                PR2=sprintf(' %f',err_true);
                PR=[PR PR2];
            end
            disp(PR)
        end
    end
    
    t=1;    
    while (t <= t_max)
        
        % Compute the new value of Gmu=(y-omega)/(delta+V);
        %Gmu=(Y-W)./(var_noise+V);
        V=abs(V);
        if (t>1)
            H=0.5*erfc(-Y.*W./sqrt(2*V));
            Gmu=Y.*exp(-W.^2./(2*V))./(H.*sqrt(2*pi.*V)+1e-20);
        else
            Gmu=0;
        end
        V=((G.^2)*F_b);
        W=G*F_a-V.*Gmu;
        
        %W_new=(G*F_a')'-((Y-W).*((var_noise+V).^(-1))).*V_new;

        %Iterate ----
        crit_test=0;
        
        % compute the gout!

        this_H=0.5*erfc(-Y.*W./sqrt(2*abs(V)));
        this_Gmu=Y.*exp(-W.^2./(2*V))./(this_H.*sqrt(2*pi.*V)+1e-20);
        
        %Compute the new Sigma_i O(M)
        S2=((this_Gmu.*(W./V+this_Gmu))'*(G.^2)).^(-1);
            
        %Compute the new R_i O(M)
        var_2=this_Gmu'*G;        
        R=F_a+(var_2.*S2)';
   
        %Compute the new values a and c O(1)
        F_a_new=Fun_a(S2,R',rho,exp_gauss,sqrt_var_gauss.^2)';
        F_b_new=Fun_b(S2,R',rho,exp_gauss,sqrt_var_gauss.^2)';
            
        crit_test=mean2(sqrt((F_a-F_a_new).^2));
            
        %udate final a and b
        F_a=F_a_new*damp_mes+(1-damp_mes)*F_a;
        F_b=F_b_new*damp_mes+(1-damp_mes)*F_b;
            
        % Test of the convergence : Are the averages constant in time or enough
        % accuratly reconstructed?
        if (crit_test <= conv_criterion_t)
            disp('Converged');
            break
        end
        if (max(size(S)) > 2)
            solution=Fun_solution(S2,R',rho,exp_gauss,sqrt_var_gauss.^2)';
            err_true=sum(abs(solution-S))/(2*N);
            if (err_true <= conv_criterion_acc)
                disp('Solution found');
%                break
            end
        end
        
        %Printing to screen
        if ((affichage > 0)&&(mod(t,affichage) == 0))
            PR=sprintf('%d %e %f',full([t crit_test damp_mes]));
            if (~(max(size(S)) < 2))
                PR2=sprintf(' %f',err_true);
                PR=[PR PR2];
            end
            disp(PR)
        end
        t=t+1;
        
%        subplot(1,3,1)
%        plot(this_Gmu)
%        subplot(1,3,2)
%        plot(this_Gmu.*(W./V+this_Gmu))
%        subplot(1,3,3)
%        plot(S2)
%        drawnow()
        %pause()
        
    end

    if (max(size(S)) > 2)
        disp('Final average error of the reconstruction');
        solution=Fun_solution(S2,R',rho,exp_gauss,sqrt_var_gauss.^2)';
        disp(err_true);
        final_error=err_true;
    end
    
    X=solution';  mean=exp_gauss; variance=sqrt_var_gauss.^2;
    
    disp('TESTING THE GENERALIZATION ERROR');
    test_sum=0;
    for i=1:10000
        newPhi=randn(1,N)/sqrt(N);
        newZ=newPhi*S;
        newY=sign(newZ);
        Z_mean=newPhi*F_a;
        Z_var=sum(F_b)/max(size(F_b));
        probminus=0.5*(1+erf(-Z_mean/sqrt(2*Z_var)));
        average=1-2*probminus;
        test_sum=test_sum+(average-newY)^2;
    end
    test_sum/10000

    
end

    
