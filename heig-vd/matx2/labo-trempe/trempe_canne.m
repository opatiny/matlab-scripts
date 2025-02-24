%% Courbe temperature trempe a l'eau
clear; clc; close all;

%% data
data = readtable('trempe-canne-T.csv');
temperature = data.T; % [°C]
time = 1:length(temperature); % [s]

%% plot
figure();
plot(time, temperature, '.-');
grid on;
xlabel('Temps [s]');
ylabel('Température [°C]');
xlim([0, 65]);