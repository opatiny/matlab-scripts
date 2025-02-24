%% TechMes: Chap4 - Ex 3
clc; clear; close all;

%% variables
data = load('./Data/GroundPressureGusev.txt');
N = length(data);

nbClasses = round(sqrt(N));

%% Histogram
histData = histcounts(data, nbClasses);

figure();
histogram(data, nbClasses);
title("Pressure histogram");
grid on;

%% Probability of liquid water
% pressure has to be over 890 Pa

probability = sum(data>890)/N % around 63%