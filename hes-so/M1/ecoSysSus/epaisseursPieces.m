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
E_bois = 13e9; % Pa, chene dans le sens des fibres

E = E_bois;

%% formules
% epaisseur e
getE = @(I, w) (12*I/w)^(1/3);

%% support canon: poutre avec 1 encastrement
% old values
% Ls = 0.065; % m
% ws = 0.025; % m
Ls = 0.085; % m
ws = 0.065; % m

I = Fmax*Ls^2/(2*E*theta);

es = getE(I, ws)

%% bati: poutre sur 2 appuis
Lb = 0.166; % m
% on diminue la largeur dans la v2 de 3cm
wb = 0.17; % m

M = Ls*Fmax; % Nm

I = -M/(6*E*tan(theta)*Lb)*(6*a*Lb - 2*Lb^2 - 6*a^2);

eb = getE(I, wb)


%% calcul des masses des pieces

rho_ac = 7850; % kg/m^3
rho_al= 2700; % kg/m^3
rho_bois = 850; % kg/m^3, chêne

rho = rho_bois;

% m = rho*V

getMass = @(L,w,e) rho*L*w*e

% support canon
ms = getMass(Ls,ws,es)


% bati
mb = getMass(Lb,wb,eb)

% support moteur
L = 1;
w = 1;
h = 1;

Vmm3 = 30527.1; % mm^3
V = Vmm3*1e-9; % m^3

mm = rho*V

% bloc electro-aimant

Vmm3 = 24000; % mm^3
V = Vmm3*1e-9; % m^3

me = rho*V

% support capteur
Vmm3 = 1960; % mm^3
V = Vmm3*1e-9; % m^3

mc = rho*V

% chene massif hornbach
prix_1kg = 20/(0.022*0.250*1.200*rho)