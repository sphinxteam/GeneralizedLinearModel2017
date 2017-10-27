function [ F_a_obtained ] = f_a_BinarySuper(S2,R,PRIOR)

F_a_obtained=PRIOR./(PRIOR+(1-PRIOR).*exp((1-2*R)./(2*S2)));
    
end
