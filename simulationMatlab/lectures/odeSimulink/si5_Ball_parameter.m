%% si5

%% exercise 1: free falling ball hits ground
clear,clc
% ODE free fall: y'' = -g
% STOP when ball hits the ground

h=10;       % initial height [m]
g=9.81;     % gravity [m/s^2]

%% exercise 2 boincing ball
clear,clc
% a) elastic
h=10;       % initial height [m]
g=9.81;     % gravity [m/s^2]

% when the ball contacts ground it acts like a spring
c=0.15; % damping constant [N/(m/s)]
k=10;   % stiffness [N/m]
m=0.1;  % mass [kg]

% b) inelastic
% when the ball contacts ground the velocity changes 
% by the factor c 
c=-0.8;












