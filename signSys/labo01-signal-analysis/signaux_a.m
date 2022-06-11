function [x1,x2,x3,x4,x5,tt] = signaux_a()
% signaux_a() 
%     Construction et affichage des signaux SINAM, SIR, SIT et SIE
%   output:
%       x1 : signal sinusoid
%       x2 : suite d'impulsion triangulaire
%       x3 : suite d'impulsion exponentielle
%       x4 : suite d'impulstion rectangulaire
%       x5 : suite d'impulsion oscillante amorties
%   auteur: dly   
%   date: 16.02.2021
%   modif.:

%% Variables générales
tmin = -5; % [s]
tmax = 25; % [s]
N = 1000; % [-]

dt = (tmax-tmin)/N;

tt = tmin:dt:tmax-dt;

%% x1 - sinus
A = 1; % [-]
T0 = 5; % [s]
f0 = 1/T0;
dephasage = 0.5; % [s]

x1 = A*sin(2*pi*f0*tt - dephasage/T0*(2*pi)); 

%% x2 - triangle
A = 4; % [-]
T0 = 5; % [s]
f0 = 1/T0;
rc = 1; % [-]
dephasage = 2.5; % [s]

x2 = A*sit(tt-dephasage,T0, rc);

%% x3 - exponential
A = 2; % [-]
T0 = 5; % [s]
f0 = 1/T0;
tau = 1; % ??
dephasage = 2.5; % [s]

x3 = A*sie(tt-dephasage,T0, tau);

%% x4 - square
A = 2; % [-]
T0 = 5; % [s]
f0 = 1/T0;
rc = 1/5; % [-]
dephasage = -0.5; % [s]

x4 = A*sir(tt-dephasage,T0, rc);

%% x5 - damped
A = 1; % [-]
T0 = 5; % [s]
f0 = 1/T0;
tau = 1; % ??
Tp = 1; % [s]
dephasage = 0; % [s]

x5 = A*sinam(tt-dephasage,T0, tau, Tp);

end