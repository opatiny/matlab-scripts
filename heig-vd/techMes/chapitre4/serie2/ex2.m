%% TechMes: Chap4 - Serie 2 - Ex 2
clc; clear; close all;

%% variables
N = 1000; % nb measures
nbBacteria = 0:10;
frequencies = [334,224,150,101,67,45,31,19,14,9,6];

%% plot data
figure();
bar(nbBacteria, frequencies);
title('Frequency VS nb bacteria per mm^2')

%% stats
probabilities = frequencies/N

% average = 1.89, std = 2.15, median = 0.74
[average, std, median, ~] = histogramStats(frequencies, nbBacteria)

% we see that mode = 0

%% less than 7 bacteria active

% we sum the probabilities from 0 to 6 bacteria active
probLessThanSeven = sum(probabilities(1:7))
% about 95%