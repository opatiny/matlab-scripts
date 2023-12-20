%% Freq de resonnance theorique pour x = 0.7mm
clear; clc; close all;

data = ...
[0	0.32
30	0.27
60	0.15
90	-0.004
120	-0.17
150	-0.28
180	-0.31];

phi = data(:,1)
Uout = data(:,2)


% theoretical data
A = 0.5; % V
phi_th = 0:1:180;
Uout_th = 2/pi*A * cos(deg2rad(phi_th));

%% plot
figure();
plot(phi, Uout, 'o'); hold on;
plot(phi_th, Uout_th, '-');
hold off;
grid on;
xlabel('\phi [°]');
ylabel('U_{out} [V]');
legend('Mesures', 'Modèle théorique','Interpreter','latex');
