%% Exercice 1.1
clear; clc; close all;

%% Simulation parameters
calculationPrecision = 0.1; % [s]

%% Variables
simTime = 60; % [s]

% gains
Kp = 20; % [V/V]
Ka1 = 1250/3; % [N/V]
Kmv = 0.18; % speed sensor [V/m/s]

% other
vc = 120; % [km/h]
vc = vc/3.6/Kp; % [m/s]
m = 1500; % vehicle mass [kg]

% adding more constraints
% coming on a slope
tSlope = 30; % [s]
g = 9.81; % [m/s/s]
alpha = deg2rad(10); % [rad]

% adding a delay
delay = pi/3; % [s]

