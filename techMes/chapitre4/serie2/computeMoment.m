function moment = computeMoment(histData, binsMiddle, order)
% computeMoment: Compute the moment of the given order
%   - histData: nb of occurences in each class
%   - binsMiddle: edges of the bins of the histogram
%   - order: order of the moment to compute
% returns: 
%   - moment: the moment of the given order
nbValues = sum(histData);

normalisedHistogram = histData/nbValues;

moment = sum(normalisedHistogram .* binsMiddle .^ order);
end

