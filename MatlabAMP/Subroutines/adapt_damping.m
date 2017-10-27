function [ damp_mes ] = adapt_damping(crit_test,last_val_conv,damp_mes)
    if (crit_test > last_val_conv)
        damp_mes=damp_mes-0.05;
    else
        damp_mes=damp_mes+0.05;
    end
    if (damp_mes > 1)
        damp_mes=1;
    end
    if (damp_mes < 0.05)
        damp_mes=0.05;
    end
end

