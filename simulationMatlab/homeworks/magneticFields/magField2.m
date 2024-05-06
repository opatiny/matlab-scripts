%% Assignment 6 - Magnetic fields - Problem 2
clear; clc; clf;
% Helmotz coil

%% Variables
% mu0 = 4e-7*pi; % vacuum permeability [H/m]
syms mu0 N L R I z x;
% restrict variables! otherwise won't be able to solve
syms mu0 N L R I positive;
syms z x real;
% N: nb windings
% L: coil length
% R: coil radius
% I: current

%% integrate over coil

r = sqrt(R^2 + (z-x)^2);
dBz_dx = mu0*I*R^2*N/(2*r^3*L);

xmin = -L/2;
xmax = L/2;

Bz = int(dBz_dx, x, xmin, xmax)
% output of this line is just Bz = int((I*N*R^2*mu0)/(2*L*((x - z)^2 + R^2)^(3/2)), x, -L/2, L/2)
