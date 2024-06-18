%% toroidal inductor with iron core
clear,clc

% parameter 
mu0=4e-7*pi;    % vacuum permeability [Vs/Am]

% source
U=163;          % amplitude [V] 
f=50;           % frequency [Hz]
w=2*pi*f;
te=20/f;        % simulation time

% coil
R=10;           % resistance [Ohm]
N=1000;         % number of windings
A=5e-4;         % cross section of magnetic circuit [m^2]
l=2*pi*0.1;     % length of magnetic circuit [m]

% a)
% linear relation between B and H: B=mu0*mur*H 
mur=1000;       % relative permeability 

% b)
% nonlinear relation
H=[10, 21.544, 46.416, 100, 215.44, 464.16, 1000, 2154.4, 4641.6, 10000];               % [A/m]
B=[0.062749, 0.13454, 0.28376, 0.56098, 0.93453, 1.2404, 1.413, 1.497,1.5364, 1.5549];  % [T]
% handle negative mag field
H = [-fliplr(H) 0 H];
B = [-fliplr(B) 0 B];

plot(H,B,'LineWidth',3), grid on
xlabel('H [kA/m]')
ylabel('B[T]')


%%
I=U/R;
H0=N*I/l;
B0=mu0*mur*H0;
L=N*B0*A/I;
Imax=U/sqrt(R^2+w^2*L^2)