%% Calcul fonction de transfer régulateur (PD)
clear; clc; close all;
init_path_MEE;

%% load fonction de transfert systeme a regler Ga

Ga = load('exports/H_lame').H;

%% specifications
% ideal values
Treg = 10e-3; % [s]
phim = 45; % [°]
wco = pi / Treg; % frequence de coupure

%% compute regulator transfer function
[~, phia] = bode(Ga, wco); % [°]
phic = phim - 180 - phia

Td = tand(phic)/wco

jw = tf('s');
Gc_initial = (1 + jw*Td);

%% gain boucle ouverte sans correction gain
Go_initial = Gc_initial * Ga;

%% correction gain regulateur
[Ko,~] = bode(Go_initial, wco)
Gc = (1/Ko)*Gc_initial;

%% gain boucle ouverte final
Go = Gc * Ga;

%% gain boucle fermee
Gyw = feedback(Go, 1);

%% plot diagrammes de bode
figure();
bode(Ga, 'y', {10, 1000}); hold on;
bode(Gc, 'b', {10, 1000});
bode(Go, 'r', {10, 1000});
grid on;
legend('G_a', 'G_c', 'G_o', 'Location', 'southwest');

%% plot reponse indicielle
figure();
subplot(2,1,1);
title('Réponse indicielle G_{yw}');
step(Gyw);
subplot(2,1,2);
title('Réponse indicielle G_{a}');
step(Ga);