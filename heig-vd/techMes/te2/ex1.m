%% Techmes - TE2 - Ex1

clc; clear; close all;

%% load data
data = importdata('data/protons.txt');


%% plot raw data and remove invalid measurements
figure();
plot(data);
axis tight;
title('Données brutes');

indices = find(data<0);
data(indices) = [];

figure();
plot(data);
title('Données sans les valeurs aberrantes');

%% histogram
N = length(data);
nbClasses = sqrt(N);

figure();
hist(data, nbClasses);

%% stats
average = mean(data)
sigma = std(data)

%% intervalle d'incertidude
uncertainty = 3*sigma;
minValue = averaga-uncertainty
maxValue = average+uncertainty
