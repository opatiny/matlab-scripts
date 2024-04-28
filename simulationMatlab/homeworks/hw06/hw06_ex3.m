%% Assignment 6 - Magnetic fields - Problem 1
clear; clc; close all;

%% Variables
R = 1;
C1 = [0,0,0];
C2 = [1,0,0];
C3 = [0,1,0]

%% Define quations
syms x y z;
sphereEq = @(R,C)(x-C(1))^2+(y-C(2))^2+(z-C(3))^2==R^2;

eq1 = sphereEq(R, C1);
eq2 = sphereEq(R, C2);
eq3 = sphereEq(R, C3);

%% Solve

[Px, Py, Pz] = vpasolve(eq1, eq2, eq3, x, y, z, [0,0,0])

%% Plot

[X,Y,Z] = sphere;

X2 = X+1;
Y3 = Y+1;

figure();
hold on;
mesh(X,Y,Z, 'EdgeColor', 'yellow', 'FaceAlpha', 0.5);
mesh(X2,Y,Z, 'EdgeColor', 'green', 'FaceAlpha', 0.5);
mesh(X,Y3,Z, 'EdgeColor', 'blue', 'FaceAlpha', 0.5);
scatter3(Px, Py, Pz, 100, 'r.');
hold off;