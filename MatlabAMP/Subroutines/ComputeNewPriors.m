function  [new_prob] = ComputeNewPriors(ave,B,L,N)
    new_prob=ave;
    epsilon=1e-6;
    for i=1:L
        i_init=1+(i-1)*B;
        i_end=B+(i-1)*B;
        prod=1;
        for j=i_init:i_end;
            this_num=1-ave(j);
            if (this_num<epsilon)
                this_num=epsilon;
            end
            prod=prod*this_num;
        end
        for j=i_init:i_end;
            this_num=1-ave(j);
            if (this_num<epsilon)
                this_num=epsilon;
            end
            new_prob(j)=prod/this_num;
        end       
    end
end

        
