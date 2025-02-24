%% Compare experimental, simulated and producer hardness
clear; clc; close all;

%% Load data
data = readtable('hardness.csv')

%% Plot
figure();
plot(data.T_exp, data.hardness_HV_exp, '.-'); hold on;
plot(data.T_kohler, data.hardness_kohler, '.-');
plot(data.T_sim, data.hardness_sim_min, '.-');
plot(data.T_sim, data.hardness_sim_max, '.-');
hold off;
xlabel('Température revenu [°C]');
ylabel('Dureté [HV]');
grid on;
legend('Valeurs expérimentales', 'Valeurs fournisseur', 'Valeurs simulées minimum', 'Valeurs simulées max');
