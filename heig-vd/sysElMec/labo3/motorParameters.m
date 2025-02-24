%% Compute motor parameters for given profile
clear; clc; close all;

%% electronics parameters
nbSteps = 200; % -
nbMicroSteps = 64; % -
i = 5; % - , rapport transmission

%% movement parameters
delta_theta = pi/2; % rad
T = 0.8; %s

%% average speeds
omega_moy_plateau = delta_theta/T
omega_moy_mot = i*omega_moy_plateau

%% profiles
profiles = [[1/2, 0, 1/2], [1/3,1/3,1/3], [1/8, 3/4, 1/8]];

[omega_max, alpha] = getTrapezeParams(profiles, T, omega_moy_mot)

%% motor parameters
fclk = 16e6; % Hz
max_velocity = 2047;

pulse_div = floor(log2(fclk*max_velocity/(2048*32*usf)))
velocity = usf*2^pulse_div*2048*32/fclk

function [omega_max, alpha] = getTrapezeParams(trapeze, T, omega_moy)
    omega_max = omega_moy/(trapeze(1)/2 + trapeze(2) + trapeze(3));
    alpha = omega_max/(trapeze(1)*T);
end