%% Estimation de l'epaisseur min des pieces
clf; clear; clc;

%% variables

thetaDeg = 2; % deg, deformation max acceptable par piece
S = 2; % security factor
theta = deg2rad(thetaDeg)/S;

Fmax = 48.4; % N
a = 0.1; % m, point fixation du support canon sur le bati

% modules d'Young
E_al = 69e9; % Pa
E_ac = 200e9; % Pa
E_bois = 13e9; % Pa

E = E_bois;

%% formules
% epaisseur e
getE = @(I, w) (12*I/w)^(1/3);

%% support canon: poutre avec 1 encastrement
Ls = 0.065; % m
ws = 0.025; % m

I = Fmax*Ls^2/(2*E*theta);

es = getE(I, ws)

%% bati: poutre sur 2 appuis
Lb = 0.166; % m
wb = 0.2; % m

M = Ls*Fmax; % Nm

I = -M/(6*E*tan(theta)*Lb)*(6*a*Lb - 2*Lb^2 - 6*a^2);

eb = getE(I, wb)


%% calcul des masses des pieces

e = max(es, eb);

rho_ac = 7850; % kg/m^3
rho_al= 2700; % kg/m^3
rho_bois = 594; % kg/m^3

rho = rho_bois;

% m = rho*V

% support canon
ms = rho * Ls*ws*es


% bati
mb = rho * Lb*wb*eb