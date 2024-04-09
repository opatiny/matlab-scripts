%% Assignment 3 - Exercise 4
clear; clc; close all;

% compute the resistance of a resistances ladder
% h are on the sides
% s are the steps
%% variables
h = 3; % Ohm
s = 2; % Ohm

nbSteps = 1;

%% result

result = ladder(5, h, s)

%% function
function Rtot = ladder(nbSteps, h, s)
    parallelResistor = @(R1, R2) R1*R2/(R1+R2);

    previous = s;
    Rtot = 0;
    for i = 1:nbSteps
        Rtot = parallelResistor(s, previous+2*h);
    end
end
