%% Homework 2 - Exercice 3
clear; clc; close all;

%% original data
original = [-6 -6 -7 0 7 6 6 -3 -3 0 0 -6;     % x-Koord.
     -7 2 1 8 1 2 -7 -7 -2 -2 -7 -7];   % y-Koord.

%% rotated
angle = pi/6;

R = [cos(angle) -sin(angle); sin(angle) cos(angle)];

rotated = R*original

%% mirrored
M = [1 0; 0 -1];

mirrored = M*original;

%% scale

S = [2 0; 0 1];

scaled = S*original;

%% plot
figure();
subplot(2,2,1);
plot(original(1,:), original(2,:), '-x');
axis equal;
title('Original');

subplot(2,2,2);
plot(rotated(1,:), rotated(2,:), '-x');
axis equal;
title('Rotated');

subplot(2,2,3);
plot(mirrored(1,:), mirrored(2,:), '-x');
axis equal;
title('Mirrored');

subplot(2,2,4);
plot(scaled(1,:), scaled(2,:), '-x');
axis equal;
title('Scaled');
