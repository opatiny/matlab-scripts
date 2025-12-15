
%% To do on initialisation file
% Comment:
%   clc; clear; close all;
%   Definition for BAtt init state of charge: BATp.initSoC=100/100;
%   Comment load of cycles: 
%   Comment all of what is related to simulation parametersy, load WLTP.mat % test profile

clear; close all; clc

%% Test in full electic mode
disp('Test fully electric mode')

load WLTP.mat % test profile
% redefine required variables
BATp.initSoC=100/100;        % Battery initial SoC (per unit)
BATp.SOC_max = 90; % (%)
BATp.SOC_min = 20; % (%)
SOC_min_stop = BATp.SOC_min; % (%)

Test_Elec = 1; % fully electric mode, thermal motor off

SIM.t_min = 0;                     % Simulation beginning
SIM.t_simul = 10*(max(CYCL.time)+10);  % Simulation end

sim('HYV_EMR_IBC_Macro.slx');


Perf.Time = Time_Final;
Perf.Distance = Distance_Final;
Perf.kWh_batt = kWh_Final;

disp(Perf);


%% Test in depletion mode
disp('Test depletion mode')

Perf.Time = 7.6657e+03;
Perf.Distance = 95.7709;
Perf.kWh_batt= 19.7964;

load WLTP.mat % test profile
BATp.initSoC = 5/100;        % Battery initial SoC (per unit)
Test_Elec = 0;
BATp.SOC_min = 20; % (%)
SOC_min_stop = 2; % (%)

SIM.t_min = 0;                    % Simulation beginning
SIM.t_simul = max(CYCL.time)+10;  % Simulation end

sim('HYV_EMR_IBC_Macro.slx');


Perf.Time = [Perf.Time Time_Final];
Perf.Distance = [Perf.Distance Distance_Final]; % in km
Perf.kWh_batt = [Perf.kWh_batt kWh_Final];
Perf.Conso_elec = [100*Perf.kWh_batt(1)/Perf.Distance(1) 100*sum(Perf.kWh_batt)/sum(Perf.Distance)]; % kWh/100km
Perf_Fuel_liter = [0 Liter_Final];
Perf.Fuel_Conso = [ 0 100*Liter_Final/sum(Perf.Distance) 100*Liter_Final/sum(Perf.Distance)*(1-Perf.Time(2)/sum(Perf.Time))];
% 2: , 3: weighted by fraction of time spent in depletion mode

disp(Perf)


%% Test on road
disp('Test real life mode')

load VD_FR.mat % test profile
BATp.initSoC = 100/100;        % Battery initial SoC (per unit)
Test_Elec = 0;

SIM.t_min = 0;                    % Simulation beginning
SIM.t_simul = max(CYCL.time)+10;  % Simulation end

sim('HYV_EMR_IBC_Macro.slx');
last_index = length(kWh_Final);

if Distance_Final(last_index)<=0.98*max(CYCL.position)/1000
    Track_test.main = 'Track not finished';
else
    Track_test.main = 'Track completed';
end

Track_test.Time = Time_Final;
Track_test.Distance = Distance_Final;
Track_test.kWh_batt = kWh_Final;
Track_test.Conso_elec = 100*Track_test.kWh_batt/Track_test.Distance;
Track_test.Perf_Fuel_liter = 100*Liter_Final/Track_test.Distance;
Track_test.SOC_Final = SOC_Final;

disp(Track_test)