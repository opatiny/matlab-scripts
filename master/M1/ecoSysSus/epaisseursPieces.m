%% Estimation de l'epaisseur min des pieces
clf; clear; clc;

%% variables

thetaDeg = 2; % deg, deformation max acceptable par piece
theta = deg2rad(thetaDeg);

Fmax = 48.4; % N
a = 0.1; % m

% modules d'Young
E_al = 69e9; % Pa
E_ac = 200e9; % Pa

E = E_ac;

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


