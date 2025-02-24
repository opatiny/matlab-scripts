%% Systeme dynamique lineaire
% Verify model with more complex system

clear; clc; close all;
init_path_MEE;

%% import data
load('./data/SBPA_sys_D.mat');

input = data(:,1)';
output = data(:,2)';
time = t';

%% simulation of the system
data = load('exports/H_sys_D');
H = data.H;
offset = data.offset;

%% simulated response
ySim = lsim(H, input, time) + offset;

%% plot
figure();
plot(time, output); hold on;
plot(time, ySim);
grid on;
legend('y(t)', 'y_{sim}(t)');