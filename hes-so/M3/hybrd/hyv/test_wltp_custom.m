%% Test WLTP renault zoe plugin hybride
clc; clear; close all;


%% Chose test file
load WLTP.mat

%% Hardware related variables
BATp.SOC_min = 20; % (%)

%% Depletion mode test

% set variables

BATp.initSoC = 1;      % Battery initial SoC (per unit)


nbCyclesMax = 10;

SIM.t_min = 0;       % Simulation beginning
SIM.t_simul = nbCyclesMax * max(CYCL.time) + 10;   % Simulation end (s)
SIM.SOC_min_stop = 5; % (-) state of charge minimal to stop simulation


% run simulation
sim('HYV_EMR_IBC_Macro.slx')


%% Self-sustaining mode test

SIM.t_min = 0;       % Simulation beginning
SIM.t_simul = max(CYCL.time) + 10;   % Simulation end (s)
SIM.SOC_min_stop = 2; % (-) state of charge minimal to stop simulation

BATp.initSoC = BATp.SOC_min;      % Battery initial SoC (per unit)


%% Real life test