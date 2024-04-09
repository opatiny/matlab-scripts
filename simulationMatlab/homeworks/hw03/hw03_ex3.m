%% Assignment 3 - Exercise 3
clear; clc; close all;

%% exact functions
f = 50; % Hz
N = 1000; % - , nb points in time vector

t = 0:1/f/N:1/f;

wn = 2*pi*f;

triangle = sawtooth(wn*t,1/2);
squareWave = square(wn*t);

%% fourier synthesis
% this does not work, problem with frequency and amplitude
[t,fourierTriangle] = fsynthesis(0, f, [0 0 0], [-1 1/9 -1/25], N);

%% plot
figure();
plot(t, triangle, 'b-');hold on;
plot(t, fourierTriangle, 'r--');
plot(t, squareWave, 'r-');
hold off;
grid on;
xlabel('t [s]');