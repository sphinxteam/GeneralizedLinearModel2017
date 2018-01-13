disp('First problem: a binary percepron with N=5001, alpha=1.5')

N=5001; alpha=1.5; rho_s=0.5; M=floor(N*alpha);
F=randn(M,N)/sqrt(N);%Gaussian
S=2*(rand(N,1)>0.5)-1;
Y=sign(F*S);

Myopt=CSBP_Solver_Opt(); 
Myopt.learning_param=0; Myopt.verbose_n=1;
Myopt.signal=S;
Myopt.damp_mes=0.8;
Myopt.prior='PM';
Myopt.nb_iter=100;
disp('RUNNING AMP')

[X, mean, variance, rho, var_noise] = AMP_PERCEPTRON_GEN(Y, F,Myopt);

disp('Press any Key')
pause

disp('Next problem: a binary percepron with N=5001, alpha=1.0')

N=5001; alpha=1.0; rho_s=0.5; M=floor(N*alpha);
F=randn(M,N)/sqrt(N);%Gaussian
S=2*(rand(N,1)>0.5)-1;
Y=sign(F*S);

Myopt=CSBP_Solver_Opt(); 
Myopt.learning_param=0; Myopt.verbose_n=1;
Myopt.signal=S;
Myopt.damp_mes=0.8;
Myopt.prior='PM';
Myopt.nb_iter=100;
disp('RUNNING AMP')


[X, mean, variance, rho, var_noise] = AMP_PERCEPTRON_GEN(Y, F,Myopt);