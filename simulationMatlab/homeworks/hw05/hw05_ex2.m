%% Assignment 5 - Exercise 2
clear; clc; close all;

% not finished
% I don't understand why it doesn't work

%% Variables
C = 10e-6; % C
R = 10; % Ohm
A_cutoff = 1/sqrt(2);

f=logspace(0,9,1000);  % log spaced frequencies
w = 2*pi*f;

%% Define transfer function
s = 1j*w;

Z_C = 1./(s*C);

Z_eq = R + par(Z_C, R + Z_C);

%% find cut-off frequency

% f_c = fzero(abs(H)-A_cutoff)


%% plot
figure();
plot(Z_eq)

figure();
subplot(1,2,1);
plot(Z_eq);
axis equal; grid on;

% subplot(1,2,2);
% bode(H);
% grid on; 