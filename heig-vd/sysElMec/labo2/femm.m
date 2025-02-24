%% Simulation elements finis
clear; clc; close all;

addpath('c:\\femm42\\mfiles');
savepath;

%% variables
minAngle = 0; % [°]
maxAngle = 44; % [°]
step = 1; % [°]

nbSteps = (maxAngle-minAngle)/step + 1;

%% Copy script
copyfile('./labo2-sem-original.FEM', './labo2-sem.FEM');

%% Load the FEM script
openfemm(); % add 0 as an argument to not actually open the femm window
opendocument('./labo2-sem.FEM');

%% loop on all angles
mi_selectgroup(1);
mi_moverotate(0,0,minAngle);

alpha = zeros(1, nbSteps);
psi_ba = zeros(1, nbSteps);
psi_b = zeros(1, nbSteps);
WmagPrime = zeros(1, nbSteps); % coenergie magnetique

for i = 1:nbSteps
    angle = (i-1)*step;
    alpha(i) = angle;
    disp(angle);
    
    mi_analyze(1);
    mi_loadsolution();

    mo_groupselectblock();
    WmagPrime(i) = mo_blockintegral(17);
    properties_I0 = mo_getcircuitproperties('Bobine');
    psi_ba(i) = properties_I0(3);
 
    %% set bobin current to 1A
    mi_setcurrent('Bobine', 1);
    mi_analyze(1);
    mi_loadsolution();
    properties_I1 = mo_getcircuitproperties('Bobine');
    psi_b(i) = properties_I1(3);
    mi_setcurrent('Bobine', 0);
    
    mi_selectgroup(1);
    mi_moverotate(0,0,step);
end

closefemm();
%% save all data
data = [alpha' psi_b' psi_ba' WmagPrime'];
table = array2table(data);
table.Properties.VariableNames(1:4) = {'alpha', 'psi_b', 'psi_ba', 'WmagPrime'};
writetable(table,'data.csv');

disp('Data saved to data.csv');

%% delete file copy
delete('./labo2-sem.FEM')
