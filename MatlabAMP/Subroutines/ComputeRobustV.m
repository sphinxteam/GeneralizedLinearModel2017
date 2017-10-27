function V = ComputeRobustV(Mvec,Y,W)
n1=1;n2=Mvec(1);
V=[];
VECT=(Y-W).^2;
for num=1:max(size(Mvec))
    A=VECT(n1:n2);
    This_V=sum(A)/(1+n2-n1);
    V=[V This_V*ones(1,(1+n2-n1))];
    
    if (num<max(size(Mvec)))
        n1=n2+1;
        n2=n2+Mvec(num+1);
    end
end
