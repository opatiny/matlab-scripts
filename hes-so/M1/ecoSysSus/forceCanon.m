%% Etude rigidite robot
clf; clear; clc;

%% variables

d = 0.15; % m
e = 0.1; % m
Dt = 0.04; % m
Db = 0.02; % m
% https://www.galaxus.ch/fr/s5/product/vbs-boules-en-bois-sans-trou-20-mm-fournitures-pour-loisirs-creatifs-39369347?supplier=9252808&utm_source=google&utm_medium=cpc&utm_campaign=PMax:+PROD_CH_SSC_Cluster_5(C)&campaignid=20448046287&adgroupid=&adid=&dgCidg=CjwKCAiA9IC6BhA3EiwAsbltONJ3s6qkDHwKnfvh2evW57FZLWLti91uWqOnwbIE01Qhe5ydXae4hBoCMKEQAvD_BwE&gad_source=1&gclid=CjwKCAiA9IC6BhA3EiwAsbltONJ3s6qkDHwKnfvh2evW57FZLWLti91uWqOnwbIE01Qhe5ydXae4hBoCMKEQAvD_BwE&gclsrc=aw.ds
mb = 0.032; % kg
k_ressort = 1100; % N/m
dx = 0.044; % m

% piston
Vp = pi*0.009^2*0.012; % m^3
rho_brass = 8730; % kg/m^3
mp = Vp*rho_brass; % kg

m = mb + mp;

margin = 0.001; % m

% constants
g = 9.81; % m/s

%% calcul force max

vA = sqrt(k_ressort/m)*dx % m/s

dy = 1/2*g*((d+e)/vA)^2 % m

delta = 1/2*(Dt - dy - Db) - margin

Fmax = k_ressort*dx

k_tot = Fmax/delta % N/m -> environ 10'000 N/m
