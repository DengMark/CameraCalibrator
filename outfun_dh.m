
function stop = outfun(x,optimValues,state,varargin)
stop = false;
% Check whether directional derivative norm is less than .01.
if abs(optimValues.residual) < .2
    stop = true;
end 
end 