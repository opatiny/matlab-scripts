%% Finite differences
clc; clear; close all;

%% define function
u = @(x) sin(x);

x = pi/4;

h = 1e-6;

%% forward scheme

du_f = (u(x+h) - u(x))/h

%% backward scheme
du_b = (u(x) - u(x-h))/h

%% central scheme
du_c = (u(x+h) - u(x-h))/(2*h)

%% compute exact value
du = cos(x)