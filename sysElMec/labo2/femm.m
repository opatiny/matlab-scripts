%% Simulation elements finis
clear; clc; close all;

addpath('c:\\femm42\\mfiles');
savepath;

%% variables
minAngle = 0; % [°]
maxAngle = 4; % [°]
step = 1; % [°]

nbSteps = (maxAngle-minAngle)/step + 1;

%% Load the FEM script
openfemm();
opendocument('./labo2-sem.FEM');

%% loop on all angles
mi_selectgroup(1);
mi_moverotate(0,0,minAngle);

alpha = zeros(1, nbSteps)
psi_ba = zeros(1, nbSteps)
psi_b = zeros(1, nbSteps)
WmagPrime = zeros(1, nbSteps) % coenergie magnetique

for i = 0:nbSteps
    angle = i*step;
    alpha(i) = angle;
    disp(angle);
    
    mi_analyze(1);
    mi_loadsolution();

    mo_groupselectblock();
    WmagPrime(i) = mo_blockintegral(17);
    
    
    mi_selectgroup(1);
    mi_moverotate(0,0,step);
end

% return to angle position alpha = 0
mi_selectgroup(1);
mi_moverotate(0,0,-maxAngle);

closefemm();

