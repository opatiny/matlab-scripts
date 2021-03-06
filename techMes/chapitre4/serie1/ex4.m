%% TechMes: Chap4 - Ex 4
clc; clear; close all;

%% variables
histData = [1,2,    5,7,5,3,5];
N = 7;
numberStudents = sum(histData);
width = 0.5;
minValue = 2.5;
maxValue = 6;

edges = minValue:width:maxValue;

%% 1) histogram
figure();
% histogram from the histogram data!!
histogram('BinCounts', histData, 'BinEdges', edges);
title("Histogram of the grades");
grid on;

%% 2->4) compute average grade, standard deviation and median
[average, std, median, cumFreq] = histogramStats(histData, edges)

% average: 4.5, std: 0.8 -> correct
% median: 4.2 -> correct

%% 5) note modale
% the mode is the most frequent class
index = find(histData == max(histData));
% grade is between
bottomValue = edges(index);
% and
higherValue = edges(index+1);

% correction: le mode est de 4.25
