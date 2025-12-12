%% Basic test to check if simulation works
% Comment:
%   clc; clear; close all;
%   Definition for BAtt init state of charge: BATp.initSoC=100/100;
%   Comment load of cycles: 
%   Comment all of what is related to simulation parametersy, load WLTP.mat % test profile

clear; close all; clc
%% load variables and test profile
init_hyv;
load WLTP.mat % test profile

ptab = load('power_lookup_table.mat')

%% set test parameters
BATp.initSoC = 100/100;        % Battery initial SoC (per unit)
SOC_min_stop = BATp.SOC_min;

Test_Elec = 1;

SIM.t_min = 0;      % Simulation beginning
SIM.t_simul = 300;  % Simulation end

%% Run simulation

sim('HYV_EMR_IBC_Macro.slx');

Perf.Time = Time_Final;
Perf.Distance = Distance_Final/1000;
Perf.kWh_batt = kWh_Final;
Perf.Fuel_liter = Liter_Final;
Perf.SOC = SOC_Final;

disp(Perf)

