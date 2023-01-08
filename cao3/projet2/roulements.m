%% Dimensionnement roulements
clc; clear; close all;
% on a une chaine de 4 engrenages droits

%% Dimensions
Mvis = 3.1; % Nm
eta = 0.95;
i = 1;
d_pignon = 0.033; % mm
alpha = 20; % °

alpha = deg2rad(alpha);
R = d_pignon/2;

% dimensions de l'assemblage qui peuvent varier
d = 0.01; % m -> doit etre le plus petit possible
L = 0.15; % m -> doit etre le plus grand possible

% calcul moments intermediaires
M2 = Mvis/(eta*i)
M1 = M2/(eta*i)
Mred = (M1 + Mvis)/(eta*i)

%% definition fonctions
Ft = @(M) M/R;
Fr = @(Ft) Ft*tan(alpha);

%% calcul forces engrenages
% engrenage 1-2
Ft1 = Ft(Mvis) % N
Fr1 = Fr(Ft1) % N

% engrenage 2-3
Ft2 = Ft(M1) % N
Fr2 = Fr(Ft2) % N

% engrenage 3-4
Ft3 = Ft(M2) % N
Fr3 = Fr(Ft3) % N

%% calculs forces roulements
% on observe que les forces sont uniquement radiales

% axe 1
B1 = sqrt(Ft1^2 + Fr1^2)

% axe 2
B2 = (L+d)/L*sqrt((Ft1 + Ft2)^2 + (Fr1-Fr2)^2)
A2 = d/L*sqrt((Ft1 + Ft2)^2 + (Fr1-Fr2)^2)

% axe 3
B3y = Fr2 -Fr3;
B3z = -(Ft2+Ft3);

B3 = sqrt(B3y^2 + B3z^2)

% axe 4
B4 = (L+d)/L*sqrt(Ft3^2 + Fr3^2)
A4 = d/L*sqrt(Ft3^2 + Fr3^2)

%% dimensionnement statique
% le roulement le plus chargé (B2) reprend environ 1500N radialement
% on va prendre tous les roulements les mêmes
forces = [B1, B2, B3, B4, A2, A4];
Fr = max(forces) % N
P0 = Fr; % car Fa = 0 pour tous les roulements

% coeff securite
S0 = 2; % [-]

% capacite de charge statique
C0 = S0*P0 % N
