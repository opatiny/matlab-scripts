clc; clear; close all;

v = round(rand(4,1)*10);

a = v.*v
b = v*v'

mean(b,2) % along second dimension


