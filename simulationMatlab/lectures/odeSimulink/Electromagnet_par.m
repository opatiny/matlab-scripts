%% Electromagnet

%% a) only electrical circuit
% voltage and current are given
% find the concatenated flux 
clear,clc,clf

% Parameter
U = 10;           % voltage [V]
R = 6.5;          % coil resistance [Ohm]
L = 44.15e-3;     % inductance [H]

w = 2*pi/0.1;     % frequency [rad/s]
te = 0.25;        % simulation time [s]



%% b) only magnetic circuit
% flux and air gap are given
% Find the coil current and the force on the armature 
clear,clc,clf

% Parameter
N = 900;          % number of windings
mu0 = 4e-7*pi;    % vacuum permeability [Vs/Am]
mur = 200;        % relative permeability iron
lfe = 0.15;       % mean length iron  [m]
A = 9e-4;         % cross section iron [m^2]
x0 = 0.01;        % initial air gap [m]

Psi = 0.15;       % concatenated flux [Wb]
w = 2*pi/0.1;     % angular frequency [rad/s]
te = 0.25;        % simulation time [s]



%% c) electromagnetic circuit
% couple both models for constant air gap 
% and reproduce the result from a) 
clear,clc,clf

% Parameter
U = 10;           % volatage [V]
R = 6.5;          % coil resistance [Ohm]
N = 900;          % number of windings
mu0 = 4e-7*pi;    % vacuum permeability [Vs/Am]
mur = 200;        % relative permeability iron
lfe = 0.15;       % mean length iron  [m]
A = 9e-4;         % cross section iron [m^2]
x0 = 0.01;        % initial air gap [m]

w = 2*pi/0.1;     % angular frequency [rad/s]
te = 0.25;        % simulation time [s]




%% d) only mechanical circuit
% external force is given
% find the armature movement due to force and gravity 
clear,clc,clf

% Parameter
m = 0.35;         % armature mass [kg]
g = 9.81;         % gravity [m/s^2]
x0 = 0.01;        % initial air gap [m]

% force
% acts against gravity, will close the air gap
Amplitude = 2*m*g;               
Period=0.05;
PulseWidth=45;
te = 0.25;        % simulation time [s]



%% e) Switch on behaviour with full modell
% couple all submodels at constant voltage
clear,clc,clf

% Parameter
m = 0.35;         % armature mass [kg]
g = 9.81;         % gravity [m/s^2]
U = 10;           % voltage [V]
R = 6.5;          % coil resistance [Ohm]
N = 900;          % number of windings
mu0 = 4e-7*pi;    % vacuum permeability [Vs/Am]
mur = 200;        % relative permeability iron
lfe = 0.15;       % mean length iron  [m]
A = 9e-4;         % cross section iron [m^2]
x0 = 0.01;        % initial air gap [m]

te = 0.20;        % simulation time [s]



%% f) Automatic switch-off with full model
% As soon as the air gap is less/more than xmin, 
% the voltage is switched off or switched on, respectively.
clear,clc,clf

% Parameter
m = 0.35;         % armature mass [kg]
g = 9.81;         % gravity [m/s^2]
U = 10;           % voltage [V]
R = 6.5;          % coil resistance [Ohm]
N = 900;          % number of windings
mu0 = 4e-7*pi;    % vacuum permeability [Vs/Am]
mur = 200;        % relative permeability iron
lfe = 0.15;       % mean length iron  [m]
A = 9e-4;         % cross section iron [m^2]
x0 = 0.01;        % initial air gap [m]
xmin=x0/2.65;
te = 1.00;        % simulation time [s]



%% g) Switch on behaviour with full modell BH characteristic
clear,clc,clf
% mur=const will be replaced by this characteristic
H=[10, 21.544, 46.416, 100, 215.44, 464.16, 1000, 2154.4, 4641.6, 10000]; % [A/m]
B=[0.062749, 0.13454, 0.28376, 0.56098, 0.93453, 1.2404, 1.413, 1.497,1.5364, 1.5549]; % [T]
plot(H,B,'-o'),hold on
xlabel('H [A/m]');ylabel('B [T]');

% Parameter
m = 0.35;         % armature mass [kg]
g = 9.81;         % gravity [m/s^2]
U = 10;           % voltage [V]
R = 6.5;          % coil resistance [Ohm]
N = 900;          % number of windings
mu0 = 4e-7*pi;    % vacuum permeability [Vs/Am]
mur = 200;        % relative permeability iron
lfe = 0.15;       % mean length iron  [m]
A = 9e-4;         % cross section iron [m^2]
x0 = 0.01;        % initial air gap [m]

te = 0.20;        % simulation time [s]

