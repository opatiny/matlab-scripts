%% Labo1B - Exercice 1 - Convolution

clear; clc; close all;

%% Variables
xn = [1 2 3 4];
hn = [5 6];

%% Compare custom and default convolutions

yn = conv(xn, hn)

yn_custom = myconv(hn, xn)
