%% Homework 2 - Exercice 1
clear; clc; close all;

t=0:0.01:2;
sinfkt=sin(2*pi*5*t);
cosfkt=sin(2*pi*3*t);
expfkt=exp(-2*t);
plot(t,[sinfkt; cosfkt; expfkt])

% to run the code we must replace comma by semicolumns
% otherwise vectors do not have the same length
% if we have a step of 0.5 we get a line x = 0 because we only evaluate the
% sine functions when they are equal 0