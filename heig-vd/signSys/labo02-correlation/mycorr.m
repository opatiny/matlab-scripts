function [rxy,lag] = mycorr(x,y)

rxy = conv(fliplr(x),y);
nbSamples = length(rxy);
lag = (1:nbSamples)-length(x);
end