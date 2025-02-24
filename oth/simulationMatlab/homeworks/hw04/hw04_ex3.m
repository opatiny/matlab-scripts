%% Assignment 4 - Exercise 2
clear; clc; close all;

%% define variables
g = 9.81; % m/s^2
v0 = 5; % m/s

angle = linspace(10,90,1000);
height = linspace(0,5,1000);

[X, Y] = meshgrid(angle, height);

%% compute range
getRange = @(beta, h0) v0*cos(beta)/g.*(v0*sin(beta) + ...
      sqrt((v0*sin(beta)).^2 + 2 * g * h0));
 
range = getRange(deg2rad(X),Y);

 %% contour
 figure();
 contour(X, Y, range, 40);
 xlabel('initial angle [°]');
 ylabel('initial height [m]');
 
 %% analysis
 % for 2.5m height, ideal angle is around 31°
