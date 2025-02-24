%% Test de rigidité du ressort
clear; clc; close all;

%% load data
data = readtable('./ressort.csv');

x = data.dx1;
F = data.F1;
x_rec = data.dx2;
F_rec = data.F2;

%% linear fit
modelParams = polyfit(x, F, 1)

model = polyval(modelParams, x);


%% plot data
figure();
plot(x, F, '.'); hold on;
plot(x_rec, F_rec, '.');
plot(x, model, '-');
hold off;
grid on;
xlim([0,5]);
xlabel('Déformation [mm]');
ylabel('Force [N]');
legend('Ressort normal', 'Ressort recuit', 'Modèle linéaire: F = 46.8x - 8.1', 'Location', 'southeast');
