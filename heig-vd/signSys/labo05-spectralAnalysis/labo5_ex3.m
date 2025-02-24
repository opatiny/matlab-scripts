%% Labo5 - Exercice 3: Signal sonore
clc; clear; close all;

%% read sound file
filename = 'comment.wav';
[xt, fe] = audioread(filename);

% soundsc(xt,fe);

%% if applicable, normalise

%% display data
N = length(xt)
Te = 1/fe;
tt = 0:Te:(N-1)*Te;

figure();
subplot(2,2,1);
plot(tt,xt);
xlabel('time [s]');
title('x(t)');
grid on;