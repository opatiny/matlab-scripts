%% Dimensionnement moteur
clc; clear; close all;

%% Dimensions
Mvis = 4.0; % Nm -> moment sur chaque vis trapezoidale
eta = 0.95; % [-]
i = 1; % [-] -> rapport de transmission

vlin = 15; % mm/min

%% Calcul moment motoreducteur
Mred = Mvis/(eta*i)^3 * ((eta*i)^2 + 1) % Nm
% avec mu = 0.1: 4.3 Nm
% avec mu = 0.2: 6.9 Nm
% avec mu = 0.28: 8.9 Nm

%% Controle moteur choisi
% specs moteur
