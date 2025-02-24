%% Diagramme B-H C45
clear; clc; close all;


%% data

H0 = [0 1000 2000 2500 4000 6000 8000 10000 15000 20000 30000 40000 50000 70000];
B0 = [ 0 0.44 0.78 0.90 1.17 1.36 1.46 1.53 1.63 1.68 1.74 1.78 1.81 1.85];

B_lin = 400* 4 * pi * 1e-7 *H0

%% plot

figure();
plot(H0, B0, 'bx-'); hold on;
plot(H0, B_lin, 'r-');
hold off;
xlabel('H [A/m]');
ylabel('B [T]');
grid on;
ylim([0,2]);