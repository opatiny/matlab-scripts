%% Activity 2: greenhouse effect
clc; clear; clf;

%% Parameters

S = 1.37e3; % kW/m^2
A = 0.1; % [-]

zeroK = 273.15; % deg C
sigma = 5.67e-8; % W/(m^2K^4)
epsilon = 1;

t = 0.1;
g = 1.33*[1, 1.01, 1.05];
c = 1.3;

%% Equations

SE = S*(1-A+g-4*A*g)./(4*(c + g*t));

TE = (SE/(epsilon*sigma)).^(1/4);

TE_celcius = TE - zeroK % deg C

globalWarming = TE_celcius-TE_celcius(1)
