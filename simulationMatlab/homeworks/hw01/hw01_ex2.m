%% Homework 1 - Exercice 2
clc; close all; clear;

%% Variables
h=[ 6 5 4; % working time in h
2 3 1;
3 2 5;
4 0 3];
k=[10, 12, 14, 9]; % wage cost in euros
s=[10, 5, 7]; % pieces

%% Losungen
a = k'.*h(:,1) % euros

b = k*h % euros

c = s*b' % euros