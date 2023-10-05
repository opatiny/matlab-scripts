%% Calcul fonction de transfer régulateur (PD)
clear; clc; close all;
init_path_MEE;

%% definition fonction de transfert systeme a regler Ga
s = tf('s');
Ga = 60e3/s^2;

%% specifications
% ideal values (desired)
Treg_d = 0.1; % [s]
phim_d = 45; % [°]
wco_d = pi / Treg_d; % frequence de coupure

zeta_c = sqrt(2)/2; % butterworth

%% compute regulator transfer function
[~, phia] = bode(Ga, wco_d); % [°]
% desired angle of the regulator at wco_d
% phase que doit amener le regulateur a une certaine frequence
phic = phim_d - 180 - phia

s = tf('s');
Gc_partiel = 1/s;

%% gain boucle ouverte sans correction gain
Go_partiel = Gc_partiel * Ga;

%% trouver dephasage requis phic du regulateur en wco_d
[~, phico_Ga] = bode(Ga, wco_d);

% dephasage induit par l'integrateur du PID
[~, phico_Go_partiel] = bode(Go_partiel, wco_d)

% angle a ajouter par le regulateur (environ 150 degres)
phic = -180 + phim_d - phico_Go_partiel;

%% resolution Td et Ti du regulateur PID

td = roots([4*tand(phic)*wco_d^2*zeta_c^2, 4*wco_d*zeta_c^2, -tand(phic)]);

Td = td(td>0); % [s]
Ti = 4*zeta_c^2*Td; % [s]

% regulateur PID avec un gain Kp = 1
Gc = (1 + s*Ti + s^2*Ti*Td)/(s*Ti);

% sans le gain
Go = Gc*Ga;

%% Calcul du gain Kp
[A_Go_wco, ~] = bode(Go, wco_d);
Kp = 1/A_Go_wco;

%% Fonction de transfert finale du regulateur
Gc = Kp * Gc;

disp(['Gi = ', num2str(1/Ti), ', Td = ', num2str(Td), ', Kp = ', num2str(Kp)])

%% Fonction finale en boucle ouverte
Go = Gc*Ga;

%% Fonction de transfert en boucle fermee
Gyw = feedback(Go, 1);

%% Exports
% save('exports/transfert_functions.mat', 'Gc','Ga','Go','Gyw', 'Kp', 'Td', 'Ti')

%% plot diagrammes de bode
figure();
bode(Ga, 'y', Gc, 'b', Go, 'r', {10, 1000}); hold on;
plot([wco_d, wco_d], [-500, 500], 'g-')
grid on;
legend('G_a', 'G_c', 'G_o', '\omega_{co,d}', 'Location', 'southwest');

%% plot reponse indicielle
figure();
subplot(2,1,1);
title('Réponse indicielle G_{yw}');
step(Gyw);
grid on;
subplot(2,1,2);
title('Réponse indicielle G_{a}');
step(Ga);
grid on;