%% Assignment 7 - Exercise 1
clear; clc; clf;

%% Rectify sine wave
T = 1; % s
N = 1000;
t = linspace(0,T,N);

f = 1/T;
sine = sin(2*pi*f*t);
halfWave = sine;
halfWave(sine<0) = 0;

fullWave = abs(sine);

%% a) RMS value
% numeric approach
computeRms = @(x) sqrt(1/T*trapz(t,x.^2));

Ueff_half = computeRms(halfWave);
Ueff_full = computeRms(fullWave);

%% b) Fourier coefficients
m = 5;

[a0, fn, an, bn] = fanalysis(t,halfWave,m);
[tf1, yf1] = fsynthesis(a0,fn,an,bn,N);
size(tf1)

[a0, fn, an, bn] = fanalysis(t,fullWave,m);
[tf2, yf2] = fsynthesis(a0,fn,an,bn,N);


%% Plot
subplot(2,1,1);
plot(t,halfWave, 'b-'); hold on;
plot(tf1, yf1, 'r--');
hold off;
grid on;

subplot(2,1,2);
plot(t, fullWave, 'b-'); hold on;
plot(tf2, yf2, 'r--');
hold off;
grid on;