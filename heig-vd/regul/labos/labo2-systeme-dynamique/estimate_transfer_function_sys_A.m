%% Systeme dynamique lineaire
% Estimation fonction de transfert: systeme D
clear; clc; close all;
init_path_MEE;

%% import data
load('./data/reponse_indicielle_sys_A.mat');

input = data(:,1)';
output = data(:,2)';
time = t';

%% find offset
offset = mean(output(1:Np)); % 0.0306 V

estimatedK = mean(output(end-Np : end))/mean(input(end-Np : end)); % 0.5448 [-]

%% simulation of the system
% transfert function
K = 0.542; % [-]
tau1 = 2.46; % s
tau2 = 0.3; % s
Tr = 0.05; % s -> half sampling period
jw = tf('s');
H = K/(1+jw*tau1)/(1+jw*tau2)*exp(-jw*Tr);

save('exports/H_sys_A', 'H', 'offset')

%% simulated response
ySim = lsim(H, input, time) + offset;

%% plot
figure();
plot(time, input); hold on;
plot(time, output)
plot(time, ySim);
grid on;
legend('u(t)', 'y(t)', 'y_{sim}(t): K = 0.542, \tau_1 = 2.47 s, \tau_2 = 0.3 s, T_r = 0.05 s');