%% TechMes: Chap4 - Ex 2
clc; clear; close all;

%% variables
data = load('./Data/PhotonsGammaGermanium.txt');
N = length(data);

maxValue = max(data);

%% 1) compute stats

average = mean(data);
median = median(data);
mode = mode(data);
std = std(data);

%% 2) histograms

widths = [300,1200,3000];

nbClasses = ceil(maxValue./widths)

histData = cell(3,1);

for i=1:length(widths)
    histData{i} = histcounts(data, nbClasses(i));
end

figure();
subplot(3,1,1);
histogram(data,nbClasses(1));
title("Bin width: 300 mm");

subplot(3,1,2);
histogram(data,nbClasses(2));
title("Bin width: 1200 mm");

subplot(3,1,3);
histogram(data,nbClasses(3));
title("Bin width: 3000 mm");

%% 3) compute stats from histograms
normalisedHistograms = cell(3,1);

for i=1:length(widths)
    normalisedHistograms{i} = histData{i}/N;
end

% find the value of the middle of each bin
possibleValues = cell(3,1);

for i=1:length(widths)
    array= 1:nbClasses(i);
    possibleValues{i} = widths(i)*array - widths(i)/2;
end

averages = zeros(3,1);
stds = zeros(3,1);

for i=1:length(widths)
    averages(i) = sum(normalisedHistograms{i} .* possibleValues{i});
    eqm = sum(normalisedHistograms{i} .* possibleValues{i} .^ 2) - averages(i)^2;
    stds(i) = sqrt(eqm);
end

disp("Original average and std: " + round(average) + ", " + round(std));
disp("Average and std for bin width 300: " + round(averages(1)) + ", " + round(stds(1)));
disp("Average and std for bin width 1200: " + round(averages(2)) + ", " + round(stds(2)));
disp("Average and std for bin width 3000: " + round(averages(3)) + ", " + round(stds(3)));
% the fewer bins they are, the farther the computed stats from the original ones