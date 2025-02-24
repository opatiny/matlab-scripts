%% Plot resilience
clear; clc; close all;

%% Load data
data = readtable('resilience.csv');

%% Linear fit
p = polyfit(data.T_rec, data.resilience, 1)
model = polyval(p, data.T_rec);

%% Plot
figure();
plot(data.T_rec, data.resilience, 'o'); hold on;
plot(data.T_rec, model, '-');
xlabel('Température revenu [°C]');
ylabel('Résilience [J]');
legend('Valeur expérimentales', 'Modèle: y = 0.33x - 84', 'Location', 'southeast');
hold off;
grid on;