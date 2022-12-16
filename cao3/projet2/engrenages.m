%% Dimensionnement engrenages
clc; clear; close all;

%% Dimensions
% si engrenages en bronze
sigma_adm_b = 20e6; % Pa -> bronze
mu_bb = 0.2; % [-] -> bronze sur bronze

% si engrenages en acier
sigma_adm_c45 = 670e6; % Pa -> acier C45
mu_acier = 0.2; % [-] -> pour Ac37 poli sur Ac37 poli

mu = mu_acier;
sigma_adm = sigma_adm_c45;
Mred = 6.9; % Nm -> moment motoreducteur

Z = 33; % [-] -> d = 35 mm
m = 0.001; % m
alpha = 20; % degrees
alpha = deg2rad(alpha);

%% Largeur minimale requise
bmin = 2*Mred*5.47/(Z*m^2*sigma_adm)
% acier c45, avec mu = 0.1: 2.1 mm et on a b = 15 -> OK
% acier c45, avec mu = 0.2: 3.4 mm

%% Rendement engrenement
eta = 1 - 2 * mu / sin(2*alpha)*2/Z % [-]
% 96% pour acier-acier
