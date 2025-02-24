%% Systeme dynamique lineaire
% Estimation fonction de transfert: systeme D
clear; clc; close all;
init_path_MEE;

%% import data
load('./data/reponse_indicielle_sys_D.mat');

input = data(:,1)';
output = data(:,2)';
time = t';

%% find offset
offset = mean(output(1:Np)) % 0.0258 V

estimatedK = mean(output(end-Np : end))/mean(input(end-Np : end)); % 0.999 [-]

%% simulation of the system

K = 0.995;
zeta = 0.23;
wn = 2.38; % rad/s
jw = tf('s');
Tr = 0;
H = K/(1+jw*2*zeta/wn + (jw/wn)^2)*exp(-jw*Tr); % derniere partie: ajout d'un retard pur

save('exports/H_sys_D', 'H', 'offset')

%% simulated response
ySim = lsim(H, input, time) + offset;

%% plot
figure();
plot(time, input); hold on;
plot(time, output)
plot(time, ySim);
grid on;
test = ['y_{sim}(t): K = ' num2str(K)  ', zeta = ' num2str(zeta) ', w_n = ' num2str(wn) ' rad/s'];
legend('u(t)', 'y(t)', test);