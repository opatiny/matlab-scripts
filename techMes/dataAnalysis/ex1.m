%% TechMes: Chap4 - Ex 1
clc; clear; close all;

%% variables

f_ideal = 100; % [mm]
n = 1.5; % [-]
N = 1000; % nb lentilles

R = load('./Data/RayonDeCourbure.txt');

f = R / (n-1);

%% 1.1) find good lenses with 2% error

relativeError = 0.02; % [-]

lowLimit = f_ideal* (1 - relativeError);
highLimit = f_ideal* (1 + relativeError);

nbGoodLenses = sum(f>lowLimit & f<highLimit);
% => nbGoodLenses = 657

disp("Number of lenses with 2% error: " + nbGoodLenses);

percentGoodLenses = nbGoodLenses/N;


%% 1.2) find 90% best lenses

toKeep = 0.9; % [-]

% percentile = prctile(f, toKeep) -> not a good approach

errors = abs(f - f_ideal);

sortedErrors = sort(errors);

index = N*toKeep;

error90 = sortedErrors(index); % approx 3.34 mm

disp("Error of the 90% best lenses in mm: " + error90);

%% 2) compute stats

average = mean(R)
median = median(R)
mode = mode(R) % why isn't this correct??
std = std(R)

%% 3) histogram
nbClasses = [5, 10, 20, 40];

figure();
subplot(2,2,1);
histogram(f,5);
title("5 classes");

subplot(2,2,2);
histogram(f,10);
title("10 classes");

subplot(2,2,3);
histogram(f,20);
title("20 classes");

subplot(2,2,4);
histogram(f,40);
title("40 classes");


%% 4) optimal histogram
% je prendrait 32 classes pour suivre la règle vue en classe
optimalNbClasses = round(sqrt(N))

figure();
histogram(f,optimalNbClasses);
title("32 classes");

%% 5) collegue computes stat on 32 classes histogram
% it's normal they don't get the same results, because he doesn't have the
% exact data, only the histogram, which has approximations (loss of
% information)
