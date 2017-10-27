function [ damp ] = damping(b,c,m)
% compute the damping of b and c by a factor m

damp=m.*b+(1-m).*c;

end

