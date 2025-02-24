%% Dimensionnement moteur
clc; clear; close all;

%% Dimensions
Mvis = 3.1; % Nm -> moment sur chaque vis trapezoidale
eta = 0.95; % [-]
i = 1; % [-] -> rapport de transmission

v0 = 0.015; % m/min -> vitesse ecartement mors
vlin = v0/2; % m/min -> vitesse de 1 ecrou
p = 0.002; % m -> diam vis 10 mm

%% Calcul moment motoreducteur
Mred = Mvis/(eta*i) * ((eta*i)^2 + 1) % Nm
% avec mu = 0.1: 4.3 Nm
% avec mu = 0.2: 6.9 Nm XX 6.2 Nm-> on prend cette valeur
% avec mu = 0.28: 8.9 Nm

%% Vitesse rotation necessaire sortie reducteur
% il s'agit de la vitesse de rotation des vis trapezoidales
omega = vlin/p % rpm

%% Controle moteur choisi
% specs moteur
M_mot = 0.0294; % Nm
omega_nom = 12200; % rpm
i = 679; % [-] -> rapport transmission reducteur
eta_red = 0.5; % [-] -> rendement reducteur max de 0.55

% sortie reducteur
M_red_max = M_mot*eta_red*i % Nm -> valeur theorique, en realite limitee par le reducteur
omega_red_max = omega_nom/i % rpm