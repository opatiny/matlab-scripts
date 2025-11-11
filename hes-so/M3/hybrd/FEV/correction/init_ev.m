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
clc; clear; close all;
%% *************************************************************************
%                     Battery Parameters                
% *************************************************************************
BATp.ns = 96;            % Battery number of cells in series
BATp.np = 2;             % Battery number of modules in parallel
BATp.Ccell= 70;          % Battery capacity of one cell (Ah)
BATp.Unm= 4.17;          % Battery maximal voltage in one cell (V)
BATp.Rcell= 0.0012/2;      % Battery resistance in one cell (Ohm)
BATp.Cap = BATp.Ccell*BATp.Unm*BATp.ns*BATp.np;
% OCV= f(SOC) from Kokam @ 25°C 
BATp.SoC = [0 1.0 4.8 10.0 20.0 30.0 40.0 50.0 60.0 70.0 80.0 90.0 100.0000];                                                      % Battery SoC (%)
BATp.OCV = [0.6420 0.7530 0.8040 0.8230 0.8420 0.8570 0.8680 0.8780 0.8910 0.905 0.92 0.94 1.0000]; % Battery OCV (per unit)
BATp.OCV_tot = BATp.OCV*BATp.ns*BATp.Unm;

BATp.initSoC=100/100;        % Battery initial SoC (per unit)

%% *************************************************************************
%                     Motor Parameters
% 					Normally Synchronous Machine with wound rotor
% 					Modelled as an equivalent DC Machine                
% *************************************************************************
% --- Description ---
EMp.U_arm_nom = 400;          % Nominal voltage of the armature (V)
EMp.I_arm_nom = 200;          % Nominal current (A)
EMp.I_arm_max = 300;          % Max current (A)
EMp.N_nom = 3120;             % Nominal speed (tr/min)
EMp.N_max = 12000;            % Maximal speed (tr/min)
EMp.P_max = 100.0e3;          % Maximal Power (W)
EMp.T_max = 245;              % MAximal Torque (Nm)
EMp.K_em = 0.9;               % Coeff for machine magnetisation (Nm/A)
EMp.J = 0.20;                 % Rotor Inertia (kg.m^2)
% --- Armature winding ---
EMp.R_arm = 0.035;             % Armature resistance (Ohm)
EMp.L_arm = 20.0e-3;           % Armature inductance (H)


%% *************************************************************************
%                     Power Electronics (EDp)                   
% *************************************************************************
EDp.eff=0.96;           % ELectric Drive efficiency (%)


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
CHAp.M_eq = 1500+2*75;            % Equivalent mass (chassis + 2 passengers)
K=1/(MTp.k_gear*MTp.k_diff/MTp.R_wheel);
CHAp.M_tournant = EMp.J/K^2; % equivalent a 180 kg

%% *************************************************************************
%                    Environment - Road parameters (RDp)                  
% *************************************************************************
% --- Mechanical source parameters ---
RDp.g = 9.81;                 % gravity (m/s^2)
RDp.A = 1.8;                    % Frontal aera (m^2)
RDp.Cx = 0.75;                % Drag coefficient
RDp.ro = 1.223;               % Density of the air with 20°C under 1013 mbar (kg/m^3)
RDp.Kaero = RDp.ro*RDp.Cx*RDp.A/2; % Constant for the resistance force to aerodynamics
RDp.f = 0.008;               % Static friction force (N)

%% CONTROL PARAMETERS
%% -------------------------------------------------------------------------
%		Maximal Control Structure :
%       - all variable are considered ideal
%       - all sensors are considered ideal
%       - synthesis carried out uninterrupted
% -------------------------------------------------------------------------
% motor PI controller
Kp_imot = 4;
Ki_imot = 1;

% chassis PI controller
Kp_chas = 50000;
Ki_chas = 0;

%% *************************************************************************
%                         Chassis inversion (CHAi)                        
% *************************************************************************


%% *************************************************************************
%                            TESTS PROFILE (CYCL)
% *************************************************************************
load TEST.mat % test profile


% *************************************************************************
% 			 	     Simulation parameters (SIM)
% *************************************************************************
% --- Global simulation ---
SIM.t_min = 0;                     % Simulation beginning
SIM.t_simul = max(CYCL.time)+10;  % Simulation end

% *****************************************************************
% 				   Display of initialization end 
% *****************************************************************

disp(' ');
disp('****** Initialisation  ******');
disp('******  completed          ******');
disp(' ');

