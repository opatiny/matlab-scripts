function [rxy,lag] = customXcorr(x,y)
% customXcorr() 
%     Compute the cross-correlation between x and y
%   inputs:
%       x: Signal to translate
%       y: Signal to translate
%       xn: Signal to keep fixed
%   outputs:
%       rxy: The cross-correlation
%       lag: Vector with the values of k (the lag)

  rxy = conv(fliplr(x),y);
  nbSamples = length(rxy);
  lag = (1:nbSamples)-length(x);
end