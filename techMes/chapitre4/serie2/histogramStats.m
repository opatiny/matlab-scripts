function [average, std, median, cumulatedFrequencies] = histogramStats(histData, binsMiddle)
% histogramStats: Find average and standard deviation of the data of a
%                 histogram
%   - histData: nb of occurences in each class
%   - binsMiddle: edges of the bins of the histogram
% returns: 
%   - average: average of the histogram data
%   - std: standard deviation of the histogram
%   - median: median of the data (linearily interpolated)
%   - cumulatedFrequencies: the cumulated histogram of the frequencies
%                           (between 0 and 1)
nbValues = sum(histData);
nbClasses = length(histData);

nbValues
normalisedHistogram = histData/nbValues; % probability for each value

%% computing average
average = sum(normalisedHistogram .* binsMiddle);

%% computing standard deviation
eqm = sum(normalisedHistogram .* binsMiddle .^ 2) - average^2;
std = sqrt(eqm);

%% computing cumulative frequency histogram
cumulatedFrequencies = zeros(1, nbClasses);
previousValue = 0;
for i=1:nbClasses
    currentValue = previousValue + normalisedHistogram(i);
    cumulatedFrequencies(i) = currentValue;
    previousValue = currentValue;
end

%% computing median
index = find(cumulatedFrequencies>=0.5, 1);

ci = binsMiddle;
fi = cumulatedFrequencies;

% linear interpolation between the two values around a frequency of 50%
median = (ci(index-1)-ci(index))/(fi(index-1)-fi(index))*(0.5-fi(index-1)) + ci(index-1);
end

