function [d] = error_estimate(A,B)

d=sum((A-B).^2)./max(size(A));

end

