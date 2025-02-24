%% Réponse indicielle de la lame flexible
clear; clc; close all;
init_path_MEE;

%% import data
load('./data/reponse_indicielle_lame.mat');

input = data(:,1)';
output = data(:,2)';
time = t';

%% simulation of the system
H = load('exports/H_sys_D').H;

%% simulated response
ySim = lsim(H, input, time) + offset;

%% plot
figure();
plot(time, input); hold on;
plot(time, output)
plot(time, ySim);
grid on;
test = ['y_{sim}(t): K = ' num2str(K)  ', zeta = ' num2str(zeta) ', w_n = ' num2str(wn) ' rad/s, offset = ' num2str(offset)];
legend('u(t)', 'y(t)', test, 'Location', 'southeast');