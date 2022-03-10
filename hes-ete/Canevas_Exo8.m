%% HES d'�t� Matlab - Exo 8 - Simulation syst�me d'ordre 1
% Date : 2021.09.01
clc; clear; close all;

%% Variables
R = 10; % ohm
C = 1E-6; % farad
num = 1;
den = [R*C 1]; % polynome en jw en ordre d�croissant
H = tf(num, den);

w = logspace(1,3);

%% Diagramme de bode
%[A, phi,w] = ... % if this is used plot isn't generated automatically
% bode(H);
% grid on;
%% R�ponse indicielle
% on met brusquement 1V en entr�e et on regarde la r�ponse du circuit
% step(H);

%% Simuler la r�ponse du syst�me � r�gler
% permet de faire la m�me chose que step() � la main
% attention aux �chelles!!
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
    title('R�ponse indicielle');
    legend('Signal d''entr�e', 'R�ponse du syst�me');
    
subplot(2,1,2);
    plot(tt, u2, tt, y2);
    title('R�ponse indicielle � un sinus');
    legend('Signal d''entr�e', 'R�ponse du syst�me');
    
