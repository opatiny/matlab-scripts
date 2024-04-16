%% Assignment 4 - Exercise 2
clear; clc; close all;

%% load data

data = xlsread('hw04_population.xlsx');

population = data(:,3);
N = length(population);

% source: ch.mathworks.com/matlabcentral/answers/1678814-how-to-extract-digits
power10 = 10.^floor(log10(population));
firstDigit = floor(population./power10);

%% Benford's law
x=1:10;
benford = N * log10(1 + 1./x);

%% histogram
histogram(firstDigit); hold on;
plot(x,benford);
hold off;