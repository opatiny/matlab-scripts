%% 3D plot showing wind speed
clear; clc; close all;

data = readtable('./caracVent.csv');
% convert table to matrix
data = data{:,:};
%% variables

y = [-5, 0, 5];
x = [5, 10, 15, 20, 25, 30];

%% plot
figure;
mesh(y,x, data)
xlabel('x [cm]')
ylabel('y [cm]')
zlabel('Vitesse du vent [m/s]')
