%% Matlab - Ex 4

clc; clear; close all;

%% Chargement des données mesurées
mesures = load('mesures_rep_ind_foehn.dat');

%% Variables definition
t = mesures(:,1);
u = mesures(:,2);
Tm = mesures(:,3);

%% Average of T_m
indices = find(Tm>3.5);
values = Tm(indices(1):end);
average = mean(values);

%% Saving data
save ex2.mat;
mesure = [t u Tm];
save('ex2.xls', 'mesure', '-ascii');

%% Affichages
figure;
h = plot(t, u, t, Tm, [min(t), max(t)], [average, average]);
% set(h, 'lineWidth', 2); % increase line width
title('Réponse indicielle du foehn à un saut de tension');
xlabel('t [s]');
ylabel('u, T_m [V]');
legend('Commande corps de chauffe u(t)', 'Température mesurée T_m(t)');
legend('Location','southeast'); % move legend
%gtext('T_m(t)'); % have to click with the mouse every time
%gtext('u(t)');
text(-1, 3.3, 'T_m limit');
grid on;
