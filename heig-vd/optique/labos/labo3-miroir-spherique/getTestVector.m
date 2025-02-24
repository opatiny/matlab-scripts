function vector = getTestVector(estimatedValue,range)
% getTestVector: Create a vector with values around an estimate.
vector = linspace(estimatedValue - range, estimatedValue + range, 2* range + 1);
end

