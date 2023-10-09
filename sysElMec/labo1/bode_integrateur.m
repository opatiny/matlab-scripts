%% Diagramme de bode
clear; clc; close all;

%% variables
R1 = 10; % Ohm
R2 = 20; % Ohm
C = 1e-6; % F

R4 = R1*R2/(R1+R2) % Ohm

s = tf('s');

G = -R1/R2 * 1/(1 + R1 * C * s)


%% plot
figure();
bode(G);
grid on;

% on observe une frequence de coupure fc = 100'000 Hz
% pourquoi phi(0) = 180°??