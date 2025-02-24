%% Assignment 6 - Exercise 2
clear; clc; close all;

%% Variables
Is = 1e-12; % A
U = 8; % V
Ut = 0.025; % V
R1 = 1; % ohm
R2 = 2; % ohm
R3 = 3; % ohm
R4 = 4; % ohm
R5 = 5; % ohm

%% Define equations
syms I1 I2 I3 I4 I5;
eq1 = R3*I3 + R4*I4 == U;
eq2 = R1*I1 + R2*I2 == U;
eq3 = R1*I1 + R5*I5 + R4*I4 == U;
eq4 = I2 + I5 - I1 == 0;
eq5 = I5 + I3 - I4 == 0;

%% Solve linear system of equations
[A, b] = equationsToMatrix([eq1,eq2,eq3,eq4,eq5],[I1,I2,I3,I4,I5]);

I = A\b;

I = vpa(I,3) % A

%% Replace R5 by diode
% false results

% voltage on the diode
Ud = R2*I2 - R4*I4;

eq6 = I5 == Is*(exp(Ud/Ut)-1);
I0 = [0 0 0 0 0];
[i1,i2,i3,i4,i5] = vpasolve(eq2,eq3,eq4,eq5,eq6,I1,I2,I3,I4,I5,I0) 
