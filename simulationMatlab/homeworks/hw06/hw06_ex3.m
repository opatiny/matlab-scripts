%% Assignment 6 - Magnetic fields - Problem 1
clear; clc; close all;

%% Variables
R = 1;
C1 = [0,0,0];
C2 = [1,0,0];
C3 = [0,1,0]



%% Define quations
@(R,C)(x-C(1))^2+(y-C(2))^2+(z-C(3))^2==R^2
