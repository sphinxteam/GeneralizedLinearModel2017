disp('First problem: a Rademacher Signal with N=5001, alpha=0.6')
N=5001; alpha=0.6; rho_s=0.5; M=floor(N*alpha);

F=randn(M,N)/sqrt(N);%Gaussian matrix
S=gauss_bernoulli(N,rho_s,0,1)';  %Gauss Bernoulli signal
Z=F*S+randn(M,1)*1e-8;   %small noise!
Y=Z;

for i=1:M
    if (Z(i)>0)
        Y(i)=Z(i);
    else
        Y(i)=-Z(i);        
    end
end

%Breaking the symmetry explicitly... there is small error to be paid :-(
%Change the reconstruction rule from |z| to z is z>-kappa and -z instead...
%This solve the symmetry problem at the cose of a small additional error 
kappa=0.001;

Myopt=CSBP_Solver_Opt(); 
Myopt.learning_param=0;
Myopt.verbose_n=1;
Myopt.signal=S;
Myopt.signal_rho=rho_s;
Myopt.damp_mes=1;
Myopt.prior='GaussBernoulli';
Myopt.nb_iter=100;

[X, mean, variance, rho, var_noise] = AMP_ABS_GEN(Y, F,kappa,Myopt);

disp('Press any Key')
pause

disp('Next problem: a Rademacher Signal with N=5001, alpha=1.0')
alpha=1.0;  M=floor(N*alpha);

F=randn(M,N)/sqrt(N);%Gaussian matrix
S=gauss_bernoulli(N,rho_s,0,1)';  %Gauss Bernoulli signal
Z=F*S+randn(M,1)*1e-8;   %small noise!
Y=Z;

for i=1:M
    if (Z(i)>0)
        Y(i)=Z(i);
    else
        Y(i)=-Z(i);        
    end
end


Myopt.signal=S;
Myopt.nb_iter=100;

[X, mean, variance, rho, var_noise] = AMP_ABS_GEN(Y, F,kappa,Myopt);