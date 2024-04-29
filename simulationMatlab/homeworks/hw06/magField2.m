%% Assignment 6 - Magnetic fields - Problem 2
clear; clc; clf;
% Helmotz coil

%% Variables
% mu0 = 4e-7*pi; % vacuum permeability [H/m]
syms mu0 N L R I r z;
% N: nb windings
% L: coil length
% R: coil radius
% I: current

%% integrate over coil
dBz_dr = mu0*I*R^2*N/(2*r^3*L);

Bz = int(dBz_dr, r)

% z-L/2, z+L/2