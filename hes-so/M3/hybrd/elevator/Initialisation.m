clear; close all; clc

%% Rectifier mean out voltage
Ured = 3.0/pi*sqrt(2.0)*sqrt(3.0)*230.0;

%% Input filter
IN_filter.L = 1.0e-3;        % Coil, H
IN_filter.R = 1.0;           % Coil series resistor, Ohms
IN_filter.C = 10.0e-3;       % Capacitance, F

%% DC machine
MOT.Lm = 5.0e-3;             % armature coil, H
MOT.Rm = 0.2;                % armature series resistor, Ohms
MOT.Km = 2.4;                % machine constant, Wb
MOT.Nnom = 1500.0;           % nominal velocity, RPM
MOT.Imax = 20.0;             % maximal armature current, A

%% Supercapacitors
Scap.Uscap = 350.0;
Scap.Ls = 10.0e-3;
Scap.Rs = 1.0;

%% Mechanical parameters
Kr = 12;                     % reductor
Rp = 0.1;                    % Pulley radius, m

%% Elevator parameters
Me = 800.0;                    % cabin mass, kg
Mc = 1000.0;                   % counterweight mass, kg
Mp = 480.0;                    % max allowed weight for passengers, kg

%% Cycle definition
cycle.v = 1;                      % reference speed, m/s
cycle.a = 0.5;                    % acceleration.
cycle.d = 3.0;                    % distance between 2 consecutive floors
d = cycle.d;
v = cycle.v;
a = cycle.a;
% cycle 1: 0 to 2nd floor, no passengers
duration_1 = (2*d+v^2/a)/v;
time_1 = [0 2 4 v/a+4 4+duration_1-v/a 4+duration_1 6+duration_1 duration_1+8];
speed_1 = v*[0 0 0 1 1 0 0 0];
mass_1 = [0 0 0 0 0 0 0 0];
% cycle 2: 2nd floor to 0, half max mass of passengers
duration_2 = (2*d+v^2/a)/v;
time_2 = max(time_1)+2.0+[0 2 4 v/a+4 4+duration_2-v/a 4+duration_2 6+duration_2 duration_2+8];
speed_2 = -v*[0 0 0 1 1 0 0 0];
mass_2 = Mp/2*[0 1 1 1 1 1 1 0];
% cycle 3: 0 to 5th floor, no passengers
duration_3 = (5*d+v^2/a)/v;
time_3 = max(time_2)+2.0+[0 2 4 v/a+4 4+duration_3-v/a 4+duration_3 6+duration_3 duration_3+8];
speed_3 = v*[0 0 0 1 1 0 0 0];
mass_3 = 0.0*[0 1 1 1 1 1 1 0];
% cycle 4: 5th to 3rd floor, quater of total passenger mass
duration_4 = (2*d+v^2/a)/v;
time_4 = max(time_3)+2.0+[0 2 4 v/a+4 4+duration_4-v/a 4+duration_4 6+duration_4 duration_4+8];
speed_4 = -v*[0 0 0 1 1 0 0 0];
mass_4 = Mp/4*[0 1 1 1 1 1 1 1];
% cycle 5: 3rd to 0 floor, total passenger mass
duration_5 = (3*d+v^2/a)/v;
time_5 = max(time_4)+2.0+[0 2 4 v/a+4 4+duration_5-v/a 4+duration_5 6+duration_5 duration_5+8];
speed_5 = -v*[0 0 0 1 1 0 0 0];
mass_5 = Mp*[1 1 1 1 1 1 1 0];


% global cycle
cycle.time_ref = [time_1 time_2 time_3 time_4 time_5 max(time_5)+5];
cycle.speed_ref = [speed_1 speed_2 speed_3 speed_4 speed_5 0];
cycle.mass_ref = [mass_1 mass_2 mass_3 mass_4 mass_5 0];

%% Sim parameters
SIM.Tmax = max(cycle.time_ref);
SIM.Step_max = 1.0e-3;

%% clear all non usefull parameters
clear d duration_1 duration_2 duration_3 duration_4 duration_5
clear mass_1 mass_2 mass_3 mass_4 mass_5
clear speed_1 speed_2 speed_3 speed_4 speed_5
clear time_1 time_2 time_3 time_4 time_5
clear v a
