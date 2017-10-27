function PR = PrepareMSEforPrinting(Nvec,F_a,S)
n1=1;n2=Nvec(1);
VECT=F_a-S;
PR=sprintf(' %e ',sum((F_a-S).^2)/max(size(S)));
if (max(size(Nvec)>1))
    for num=1:max(size(Nvec))
        A=VECT(n1:n2);
        error_B=sum(A.^2)/(1+n2-n1);
        PR=[PR sprintf('%e ',error_B)];
        if (num<max(size(Nvec)))
            n1=n2+1;
            n2=n2+Nvec(num+1);
        end
    end
end
