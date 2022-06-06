%% TechMes: Chap4 - Serie 2 - Ex 3
clc; clear; close all;

%% variables
xi = -3:6;
pi = [3.4,5.1,8.6,13.7,17.1,18.8,17.8,10.3,3.5,1.7]; % [%]

probabilities = pi/100;

%% sum of 1?
sumIs1 = sum(probabilities)

%% histogram
figure();
bar(xi,pi);

%% stats
% average = 1.48, std = 2.02, median = 1.11
[average, std, median, cumulatedHistogram] = histogramStats(probabilities, xi)

%% moments

moment3 = computeMoment(probabilities, xi, 3) % ~19.7
moment4 = computeMoment(probabilities, xi, 4) % ~91.5

%% mode = 2

%% discrete repartition function?? (c koua?)
% fonction qui indique la probabilité que la valeur soit inferieure ou
% egale a x -> c'est l'histogramme cumunle
repartitionFunction = cumulatedHistogram

%% niveau de confiance
sigma = std; % on arrondi à 2
% 1 sigma -> moyenne plus ou moins 1 sigma
minValue = average-sigma; % 0.5
maxValue = average+sigma; % 3.5
% on considere que les valeurs entieres -> 0,1,2,3
prob1Sigma = sum(probabilities(4:7)) % 0.67

% 2 sigma -> moyenne plus ou moins 2 sigma
minValue = average-2*sigma; % -2.6
maxValue = average+2*sigma; % 5.5
% on considere que les valeurs entieres -> -2,-1, 0, 1, 2, 3, 4, 5
prob1Sigma = sum(probabilities(2:9)) % 0.95
