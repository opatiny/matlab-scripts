%% Validation de la fonction de transfert en boucle fermee Gyw
clear; clc; close all;
init_path_MEE;

%% load experimental data
load('data/bangbang_regulateur_PID.mat')

w = data(:,1);
y = data(:,2);
u = data(:,3);

%% load transfert functions and simulate response

load('exports/transfert_functions.mat')
Gyw = c2d(Gyw,h); % h est la periode d'echantillonage
ysim = lsim(Gyw,w,t);

%% Plot data
figure();
subplot(2,1,1);
plot(t,w,'g',t,y,t,ysim);
grid on;
legend('w', 'y', 'y_{sim}');

subplot(2,1,2);

