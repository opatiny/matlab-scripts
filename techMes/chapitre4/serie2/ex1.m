%% TechMes: Chap4 - Serie 2 - Ex 1
clc; clear; close all;

%% variables
population = 2:12;
nbCases = [1,2,3,4,5,6,5,4,3,2,1];
totalNbCases = 36;


%% plot probabilities
probabilities = nbCases/totalNbCases;

figure();
bar(population, probabilities);
title("Probability for each value when rolling 2 dices");
grid on;

%% mode
% the mode is the most frequent value: 7

%% stats

[average, std, ~, ~] = histogramStats(probabilities, population)

% median = 7 because it's the value in the middle

%% simulate rolling dices
d1 = randi(6,10000,1); % distribution uniforme entre 1 et 6
d2 = randi(6,10000,1);
s = d1+d2;
figure();
histogram(s);