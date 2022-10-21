%% Verify geometric optics laws for spherical mirror
clc; clear; close all;

%% Data and variables
data = readtable('labo3-data.csv'); % [mm]
hi = -data.hi;
xi = data.xi;
xo = data.xo;
ho = 13; % [mm]

%% Correct data
% approximate systematic errors value
delta_i = 100; % [mm]
delta_o = 90; % [mm]

% estimated range in which the errors should be
range = 15;

% create vectors to test
di_vector = getTestVector(delta_i, range)
do_vector = getTestVector(delta_o, range)

Gt_mes = hi/ho;
Gt_th = - (xi + delta_i)./(xo + delta_o);

%% plot
model = [-5,0];

figure();
plot(Gt_th, Gt_mes, '.'); hold on;
plot(model, model);
hold off;
xlabel('-(x_i + \Delta_i)/(x_o + \Delta_o) [-]');
ylabel('h_i/h_o [-]');
legend('Grandissement transversal', 'Modèle théorique')
grid on;