%% Resolution equation implicite: caclul de fres_th
clear; clc; close all;

%% load interpolated data
data = load('data_res.mat');

frequency = data.frequency;
Lb = data.Lb;
Rb = data.Rb;
fres_exp = data.fres_exp;

%% solve equation to find theoretical resonnance frequency
% the capacity is given to us
C = 39e-9; % F

% we only solve for x = 0.7mm, which has index 5
R_f = @(f) interp1(frequency, Rb(:, 5), f);
L_f = @(f) interp1(frequency, Lb(:, 5), f);
F = @(f) f - 1/(2*pi) * sqrt(1./(L_f(f)*C) - R_f(f).^2/L_f(f).^2);

fres_th = fzero(F, fres_exp);

fres_exp % 192 kHz
fres_th % 169 kHz
