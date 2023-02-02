%% Force de traction permanente possible dans l'echantillon
clc; clear; close all;

%% variables
Mred = 8; % Nm
eta = 0.95; % [-]
i = 1; % [-] -> rapport de transmission

Mvis = Mred*(eta*i) / ((eta*i)^2 + 1) % Nm

p = 0.002; % m -> pas vis
d = 0.01; % m
mu = 0.2; % [-] -> acier sur bronze

dm = d - 0.5*p;
rm = dm/2;

rho = atan(mu); % angle de frottement
gamma = atan(p/(pi*dm)); % angle d'helice


Fa_tot = 2*Mvis/(rm*tan(rho+gamma)) % N