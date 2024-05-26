%% Assignment 9 - Magnetic fields - Problem 8
clear; clc; clf;

% attraction force between 2 permanent magnets

%% variables
Br = 1.3; % T
d = 0.015; % m
L = 0.015; % m

I = 1; % A
R = 0.0075; % m
z = 0.015; % m

%% force between two current loops
mu0 = 4*pi*1e-7; % N/A^2

% todo: what should r be?
[Hz1, Hr1] = Hloop(R,R,z);

H = getNorm(Hz1, Hr1);
B = H*mu0

Fz = I*2*pi*R*B % false, approx 2x too big

%% force between current loop and coil
% what is the number of loops to get Br = 1.3 T?
% NI/L = Br/mu0
N = round(Br/mu0*L/I);

[Hz1, Hr1] = Hcoil(N,R,L,R,z);

H = getNorm(Hz1, Hr1);
B = H*mu0

Fz = I*2*pi*R*B % false, approx 2x too big