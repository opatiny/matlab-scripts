%% Verification de la loi de Bouger
clc; clear; close all;

%% load data
data = readtable('data_exp1.csv'); % [mm]
h = data.h; % [m]
eclairement = data.epsilon; % [lux]

%% Correct data
fun = @(params) params(1)./(h+params(2)).^2;

errorFun = @(params) rms(fun(params) - eclairement);
% approximate variables value
approximateParams = [10, 0.015]; % I0 [cd] and h0 [m]

% compute optimal values
params = fminsearch(errorFun,approximateParams)

I0 = params(1) % 26.5 cd
h0 = params(2) % 11.2 mm

% rms for the best fit
error = errorFun(params) % 3.5 lux

% compute theoretical model
h_th = linspace(min(h), max(h), 1000);
eclairement_th = I0./(h_th+h0).^2;

%% plot
figure();
plot(h*100, eclairement, '.'); hold on;
plot(h_th*100, eclairement_th);
hold off;
xlabel('h [mm]');
ylabel('\epsilon [lux]');
legend('Mesures', 'Modèle quadratique: I_0 = 26.5 cd, h_0 = 11.2 mm', 'Location', 'northeast')
grid on;