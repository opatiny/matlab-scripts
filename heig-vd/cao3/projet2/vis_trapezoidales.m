%% Dimensionnement vis trapezoidales
clc; clear; close all;
% on a deux vis trapezoidales en parralele

%% Dimensions
% observation: Ms augmente avec le diametre de la vis
p = 0.002; % m -> pas vis
d = 0.01; % m
mu = 0.2; % [-] -> acier sur bronze
Fa_tot = 5000; % N force axiale dans les 2 vis
b = 0.02; % m -> largeur ecrous
deq = 0.0075; % m -> egal a d3
D1 = 0.008; % m

Fa = Fa_tot/2;
a = 0.5*p;
dm = d - 0.5*p;
rm = dm/2;
nu = b/p-1;

%% Valeurs admissibles
% pression acier sur bronze
P_adm = 30; % MPa

% limite elastique acier\item
Rp02 = 1;

% module cisaillement bronze
G_CuSn = 240; % MPa -> a verifier!!!

%% Moment torsion
rho = atan(mu); % angle de frottement
gamma = atan(p/(pi*dm)); % angle d'helice

Ms = rm*Fa*tan(rho+gamma) % Nm
% mu = 0.1: 1.9 Nm
% mu = 0.2: 3.1 Nm -> on prend cette valeur
% mu = 0.28: 4.0 Nm

%% Pression de contact filet
P = Fa/(nu*pi*dm*a) % Pa -> ok si plus petit que P_adm
% 9.8 Mpa

%% Rp02 min en fonction de Fa et d
% Resistance en traction de la vis
As = pi*deq^2/4;

Rp02min = Fa/As % Pa
% 57 MPa -> acier: typiquement 200 MPa, et jusqu'a 900 MPa

%% Contrainte cisaillement filet
h1c = 0.634*p;
tau = Fa/(nu*pi*D1*h1c) % Pa
% 8.7 MPa

%% contrainte cisaillement bronze
E = 