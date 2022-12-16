%% Estimation P Hz bronze
clc; clear; close all;

% valeurs prises sur https://www.maedler.de/product/1643/1618/1034/1059/stirnzahnraeder-messing-gefraest-modul-1

Z = 10; % [-]
b = 0.0065; % m
m = 0.001; % m
M = 0.061; % Nm

Padm = 2*M*5.47/(Z*m^2*b) % Pa
% environ 10 MPa ....