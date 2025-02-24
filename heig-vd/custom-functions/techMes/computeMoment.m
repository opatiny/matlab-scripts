function moment = computeMoment(histData, binsMiddle, order)
% computeMoment()
%       Compute the moment of the given order
%  inputs:
%   histData: nb of occurences in each class
%   binsMiddle: edges of the bins of the histogram
%   order: order of the moment to compute
% outputs: 
%   moment: the moment of the given order
nbValues = sum(histData);

normalisedHistogram = histData/nbValues;

moment = sum(normalisedHistogram .* binsMiddle .^ order);
end

