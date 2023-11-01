%% Ex 3.2
clear; clc; close all;

%% variables
mu0 = 4* pi * 1e-7; % H/m
L = 0.4; % m
e = 1e-3; % m
i = 1.2; % A
n = 1000; % -
S = 1e-3; % m^2

%% data
B = [0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2]';
murTh = [1700 2000 2300 2500 2550 2400 2300 2100 2000 1500 1000]';


%% compute mur from equation

mur = B * L ./ ( n*i*mu0 - e*B)

%% plot
figure();
plot(B, murTh); hold on;
plot(B, mur);
hold off;
grid on;