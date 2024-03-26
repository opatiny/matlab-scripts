%% Homework 1 - Exercice 4
clc; close all; clear;

%% Compute function

t = 1:0.01:5;
s = 20*cos(3*pi*t).*cos(2*pi*t);

%% Zero crossings

error = 0.001;

zeroIndices = find(abs(s) < error)

zeroCrossings = s(zeroIndices);
zeroTimes = t(zeroIndices);


%% Plot

figure();
plot(t,s, 'b-'); hold on;
plot(zeroTimes,zeroCrossings, 'r.', 'MarkerSize', 10);
hold off;
grid on;