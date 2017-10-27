function [ F_a_obtained ] = f_a_P3(S2,R,rho,a,b)

N=max(size(R));

TAB_R=[R(1:N/3);R(N/3+1:2*N/3);R(2*N/3+1:end)];
TAB_S2=[S2(1:N/3);S2(N/3+1:2*N/3);S2(2*N/3+1:end)];

PZERO=exp(-TAB_R.^2./(2.*TAB_S2))+1e-8;
PPLUS=0.5*exp(-(TAB_R-1).^2./(2.*TAB_S2))+1e-8;
PMINUS=0.5*exp(-(TAB_R+1).^2./(2.*TAB_S2))+1e-8;

%000
Z_ZEROS=(1-rho)*prod(PZERO);
%LE RESTE
Z_NOT=rho*prod(PPLUS+PMINUS);
%ZTOT
ZTOT=Z_ZEROS+Z_NOT;

PROB_NUL=(Z_ZEROS./ZTOT);

MEAN=(ones(3,1)*(1-PROB_NUL)).*(PPLUS-PMINUS)./(PPLUS+PMINUS);

F_a_obtained=[MEAN(1,:) MEAN(2,:) MEAN(3,:)];
    
end