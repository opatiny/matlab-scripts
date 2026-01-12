%%% Initialisation File for bicycle simulation
%%% P. Barrade - Jan. 2019
%% Set all to 0
clear; clear all; close all; clc


%%% load Distance Altitude Speed and slope profiles
load Uvrier_HEI_Profile.mat;
disp('Profile is loaded');

%%% load Cyclist performance profile
load Cyclist_Profile.mat;
disp('Cyclist performance profile is loaded');

%%% load profile pour electrical assisance limitations
load assit_lim.mat;
disp('Electrical assisance limitations are loaded');

%% Set parameters
% Environnement
env.g = 9.81;                   % in m/s2
env.rho_air = 1.223;            % in kg/m2

% Cycle
cycle.Rp = 0.2;     % Radius of pedals, in m
cycle.Speed = [36 34 30 28 25 22 20 17 14 11]/18; % 10 speed
cycle.Rw = 0.5;                   % Wheel radius
cycle.Mass = 21.8;                % cycle mass in kg
cycle.Crr = 0.003;                % wheel friction coefficient on the road

% Cyclist
cyclist.Mass = 75;                            % Mass of the cyclist
cyclist.Fc_max = 0.5*env.g*cyclist.Mass;         % Maximal force applied by the user, in N 
cyclist.Scx = 0.4;                  % aerodynamic coefficient (standard guy)


