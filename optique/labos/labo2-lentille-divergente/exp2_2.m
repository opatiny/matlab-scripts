%% Compare measurements and theory
clc; clear; close all;


data = readtable('data.csv'); % [cm]
errors = readtable('errors.csv'); % [cm]

figure();
errorbar(data.xMes, errors.xMes,'o', "LineStyle","none");
hold on;
errorbar(data.xTh, errors.xTh,'o', "LineStyle","none");
hold off;
legend('Mesures', 'Valeurs théoriques');
ylabel('x_{i,1} [cm]');
xlabel('Numéro de l''expérience');
grid on;

figure();
errorbar(data.yMes, errors.yMes,'o', "LineStyle","none");
hold on;
errorbar(data.yTh, errors.yTh,'o', "LineStyle","none");
hold off;
legend('Mesures', 'Valeurs théoriques');
ylabel('y_{i,1} [cm]');
xlabel('Numéro de l''expérience');
grid on;