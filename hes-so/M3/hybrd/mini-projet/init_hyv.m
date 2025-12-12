% -------------------------------------------------------------------------
%%		Initialisation (Matlab)
%		for an
%       E lectric
%       V ehicule
% -------------------------------------------------------------------------
%		Source by W.Lhomme and A. Bouscayrol  : June 2005
%       Adaptated P. Barrade :         October 2022 - October 2025
%
% -------------------------------------------------------------------------
% clc; clear; close all; % comment this line to run simulink script from
% matlab script

%% is the simulation run in simulink?
SIMULINK = 1;

%% *************************************************************************
%                     Battery Parameters                
% *************************************************************************
BATp.ns = 96;            % Battery number of cells in series
BATp.np = 1;             % Battery number of modules in parallel
BATp.Ccell= 70;          % Battery capacity of one cell (Ah)
BATp.Unm= 4.17;          % Battery maximal voltage in one cell (V)
BATp.Rcell= 0.0012/2;      % Battery resistance in one cell (Ohm)
BATp.Cap = BATp.Ccell*BATp.Unm*BATp.ns*BATp.np;
% OCV= f(SOC) from Kokam @ 25 C 
BATp.SoC = [0 1.0 4.8 10.0 20.0 30.0 40.0 50.0 60.0 70.0 80.0 90.0 100.0000]; % Battery SoC (%)
BATp.OCV = [0.6420 0.7530 0.8040 0.8230 0.8420 0.8570 0.8680 0.8780 0.8910 0.905 0.92 0.94 1.0000]; % Battery OCV (per unit)
BATp.OCV_tot = BATp.OCV*BATp.ns*BATp.Unm;

if SIMULINK
    BATp.initSoC=80/100;        % Battery initial SoC (per unit)
end

BATp.SOC_min = 20; % (%)
BATp.SOC_max = 90; % (%)
SOC_min_stop = 2; % (%)


%% *************************************************************************
%                     ICE Cartography
% 					Prius_jpn 1.5L (43kW) from FA model and ANL test data'
% 					Modelled as an equivalent DC Machine   
%               fc_version=2002;
% *************************************************************************
ICE.Omega_min = 1000*2*pi/60;   % Required for identifying conditions for cranking the ICE
ICE.Omega_def = [1000 1250 1500 1750 2000 2250 2500 2750 3000 3250 3500 4000]*2*pi/60; % in rad/s
ICE.Torque_def = [6.3 12.5 18.8 25.1 31.3 37.6 43.9 50.1 56.4 62.7 68.9 75.2]*1.356;  % in Nm

ICE.Torque_max = ICE.Torque_def(end);
ICE.Omega_max = ICE.Omega_def(end);

% Fuel consumption in g/s
% columns: increasing omega, rows: increasing torque???
ICE.Fuel_consumption = [                        
  0.1513  0.1984  0.2455  0.2925  0.3396  0.3867  0.4338  0.4808  0.5279  0.5279  0.5279  0.5279 % 1
  0.1834  0.2423  0.3011  0.3599  0.4188  0.4776  0.5365  0.5953  0.6541  0.6689  0.6689  0.6689 % 2 
  0.2145  0.2851  0.3557  0.4263  0.4969  0.5675  0.6381  0.7087  0.7793  0.8146  0.8146  0.8146 % 3
  0.2451  0.3274  0.4098  0.4922  0.5746  0.6570  0.7393  0.8217  0.9041  0.9659  0.9659  0.9659 % 4
  0.2759  0.3700  0.4642  0.5583  0.6525  0.7466  0.8408  0.9349  1.0291  1.1232  1.1232  1.1232 % 5
  0.3076  0.4135  0.5194  0.6253  0.7312  0.8371  0.9430  1.0490  1.1549  1.2608  1.2873  1.2873 % 6
  0.3407  0.4584  0.5761  0.6937  0.8114  0.9291  1.0468  1.1645  1.2822  1.3998  1.4587  1.4587 % 7
  0.3773  0.5068  0.6362  0.7657  0.8951  1.0246  1.1540  1.2835  1.4129  1.5424  1.6395  1.6395 % 8
  0.4200  0.5612  0.7024  0.8436  0.9849  1.1261  1.2673  1.4085  1.5497  1.6910  1.8322  1.8322 % 9
  0.4701  0.6231  0.7761  0.9290  1.0820  1.2350  1.3880  1.5410  1.6940  1.8470  1.9999  2.0382 % 10
  0.5290  0.6938  0.8585  1.0233  1.1880  1.3528  1.5175  1.6823  1.8470  2.0118  2.1766  2.2589 % 11
  0.6789  0.8672  1.0555  1.2438  1.4321  1.6204  1.8087  1.9970  2.1852  2.3735  2.5618  2.7501 ]; % 12
% Gasoline density (g/l)
ICE.gas_dens = 730;
% Inertias and Friction
ICE.Kice = 0.025;
ICE.Jice = 0.4;

Test_Elec = 0; % fully electric mode, thermal motor off

%% *************************************************************************
%         Power Electronics and Drive - Generator + redresseur (REDR)                   
% *************************************************************************
REDR.eff = 0.98;    % (%)
REDR.K_em = 0.9;    % (Nm/A)
REDR.R_arm = 0.02;  % (Ohm)

%% *************************************************************************
%                     Power Electronics and Drive - Traction (EDp)                   
% *************************************************************************
EDp.eff=0.96;           % ELectric Drive efficiency (%)
EMp.J = 0.20;                 % Rotor Inertia (kg.m^2)
EMp.R_arm = 0.035;             % Armature resistance (Ohm)
EMp.K_em = 0.9;               % Coeff for machine magnetisation (Nm/A)
EMp.P_max = 100.0e3;          % Maximal Power (W)
EMp.T_max = 245;              % MAximal Torque (Nm)

%% *************************************************************************
%                  Mechanical Transmission parameters (MTp)               
% *************************************************************************
% Gearbox
MTp.k_gear = 3;       % Gearbox reduction
MTp.Gear_eff = 98/100;  % Gearbox efficiency
MTp.k_diff = 3;     % Differential reduction
MTp.diff_eff = 98/100;  % Differential efficiency
% --- Wheel ---
MTp.D_wheel = 0.60;           % Wheel diameter (m)
MTp.R_wheel = MTp.D_wheel/2;  % MT.D_wheel
    
%% *************************************************************************
%                         Chassis parameters (CHAp)                       
% *************************************************************************
CHAp.M_eq = 1500+2*75;            % Equivalent mass (chassis+ 2 passengers)
K = 1/(MTp.k_gear*MTp.k_diff/MTp.R_wheel);
CHAp.M_tournant = EMp.J/K^2;

%% *************************************************************************
%                    Environment - Road parameters (RDp)                  
% *************************************************************************
% --- Mechanical source parameters ---
RDp.g = 9.81;                 % gravity (m/s^2)
RDp.A = 1.8;                    % Frontal aera (m^2)
RDp.Cx = 0.75;                % Drag coefficient
RDp.ro = 1.223;               % Density of the air with 20 C under 1013 mbar (kg/m^3)
RDp.Kaero = RDp.ro*RDp.Cx*RDp.A/2; % Constant for the resistance force to aerodynamics
RDp.f = 0.008;               % Static friction force (N)

%% *************************** Auxiliaires consumption Def
Paux.Heat = 0.0e3;
Paux.Cool = 1e3;
Paux.Light = 75;
Paux.Disp = 175;
Paux.Vent = 200;
Paux.ECU = 100;

%% CONTROL PARAMETERS
%% -------------------------------------------------------------------------
%		Maximal Control Structure :
%       - all variable are considered ideal
%       - all sensors are considered ideal
%       - synthesis carried out uninterrupted
% -------------------------------------------------------------------------

%% *************************************************************************
%                         Chassis inversion (CHAi)                        
% *************************************************************************
RegV.Kp = 50000;
RegV.Ki = 0;
%% *************************************************************************
%                         ICE Inertias INV (CHAi)                        
% *************************************************************************

% good parameters pairs: P = 100, I = 1 -> Tr_max = 
RegTr.Kp = 10;
RegTr.Ki = 1;

%% *************************************************************************
%                            TESTS PROFILE (CYCL)
% *************************************************************************
load WLTP.mat % test profile


% *************************************************************************
% 			 	     Simulation parameters (SIM)
% *************************************************************************
% --- Global simulation ---

t_simul_default = max(CYCL.time)+10; % adapt simulation time to test length
SIM.t_min = 0;       % Simulation beginning
SIM.t_simul = 300;   % Simulation end (s) -> modify length of simulation here!

% *****************************************************************
% 				   Display of initialization end 
% *****************************************************************

disp(' ');
disp('****** Initialisation  ******');
disp('******  completed          ******');
disp(' ');

