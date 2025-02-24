%% Assignment 8 - Exercise 1
clear; clc; clf;

%% 2 random points
% [x y]
A = [1 8];
B = [6 3];

%% Function to minimize

fun = @(Cy) norm(A-[0 Cy]) + norm([0 Cy]-B);

P0 = (A+B)/2;
Cy = fminsearch(fun, P0(2));

C = [0 Cy]

%% Plot

matrix = [A;C;B];

plot(matrix(:,1), matrix(:,2), 'r.-', 'MarkerSize', 10);

axis equal;
xlim([0,10]);
ylim([0,10]);