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
mu0 = 4*pi*1e-7; % N/A^2

% what is the number of loops to get Br = 1.3 T?
% NI/L = Br/mu0
N = round(Br/mu0*L/I)

getB = @(H) H*mu0;
getFz = @(B) I*2*pi*R*B;

%% a) force between two current loops
% todo: what should r be?
[~, Hr1] = Hloop(R,R,z);

H = Hr1;
B = getB(H);

Fz = getFz(B)

%% b) force between current loop and coil
[~, Hr1] = Hcoil(N,R,L,R,z);

H = Hr1;
B = H*mu0;

Fz = I*2*pi*R*B

%% c) force between two touching coils (permanent magnets)
dz = L/(N-1);

% compute center of the coils
half = (N-1)/2;
zs = (0:N)*dz;

Hz = 0;
Hr = 0;

for i=1:N
   i % for debug
   [~, Hri] = Hcoil(N,R,L,R,zs(i));
   Hr = Hr + Hri;
end
