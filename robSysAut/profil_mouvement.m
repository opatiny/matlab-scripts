%% Profil de mouvement: third degree polynom
clear; clc; close all;

%% symbolic variables
syms t;

% solve the system

q = @(a) a(3)*t^3 + a(2) * t^2 + a(1)*t + a(0);

diff(q,t)