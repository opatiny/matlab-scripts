%% Assignment 12 - Exercice 2
clear; clc; clf;

%% load data
data = load('hw12_MFV.mat');

y = data.y;
fs = data.fs;
ts = 1/fs

t = 0:ts:(length(y)-1)*ts;

%% make noise

% sound(y,fs);

%% find when keys are pressed
threshold = 0.2;


smooth = movmean(abs(y),100);



%% plot
subplot(311);
plot(t,y,'-');
xlabel('Time [s]');
ylabel('Amplitude');

subplot(312);
plot(t,smooth,'-');
hold on;
yline(threshold);
hold off;
xlabel('Time [s]');
ylabel('Amplitude');