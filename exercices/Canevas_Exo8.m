%% HES d'été Matlab - Exo 8 - Simulation système d'ordre 1
% Date : 2021.09.01
clc; clear; close all;

%% Variables
R = 10; % ohm
C = 1E-6; % farad
num = 1;
den = [R*C 1]; % polynome en jw en ordre décroissant
H = tf(num, den);

w = logspace(1,3);

%% Diagramme de bode
%[A, phi,w] = ... % if this is used plot isn't generated automatically
% bode(H);
% grid on;
%% Réponse indicielle
% on met brusquement 1V en entrée et on regarde la réponse du circuit
% step(H);

%% Simuler la réponse du système à régler
% permet de faire la même chose que step() à la main
% attention aux échelles!!
N = 5000;
tt = linspace(0,10e-5,N);
A = 5;
u = A*ones(length(tt),1);
u(1:N/10)=0;
y = lsim(H, u, tt);

f0 = 7E4;
u2 = sin(2*pi*f0*tt);
u2(1:N/10)=0;
y2 = lsim(H,u2,tt);

%% Plots
figure;
subplot(2,1,1);
    plot(tt, u, tt, y);
    title('Réponse indicielle');
    legend('Signal d''entrée', 'Réponse du système');
    
subplot(2,1,2);
    plot(tt, u2, tt, y2);
    title('Réponse indicielle à un sinus');
    legend('Signal d''entrée', 'Réponse du système');
    
