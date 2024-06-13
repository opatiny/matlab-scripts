%% Assignment 12 - Exercice 1
clear; clc; clf;

%% load data
data = load('hw12_data.txt');

t = data(:,1);
y = data(:,2);

% sort time
[t, indices] = sort(t);
y = y(indices);

%% interpolate and sample
minTime = t(1);
maxTime = t(end);
N = 1000;
fs = maxTime/(N-1);

tt = linspace(minTime,maxTime,1000);
yy = interp1(t,y,tt);

%% fourier transform
F = abs(fft(yy));

%% plots
subplot(311);
plot(t,y, '.-');
title('Original data');
xlabel('Time [s]');
ylabel('Amplitude');

subplot(312);
plot(tt,yy, '.-');
title('Resampled data');
xlabel('Time [s]');
ylabel('Amplitude');

subplot(313);
plot(F, '.-');
title('Fourier transform');
xlabel('Amplitude [Hz]');
ylabel('fft');
xlim([0,500]);
