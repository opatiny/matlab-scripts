%% Homework 2 - Exercice 2
clear; clc; close all;

% we want to draw lissajoux figures
a = [1 2 3 4]';
b = [2 3 4 5]';

delta = 0;
A = 1;
B = 1;

t = (0:0.1:5);

x = A*sin(a*t + delta);
y = B*sin(b*t);




