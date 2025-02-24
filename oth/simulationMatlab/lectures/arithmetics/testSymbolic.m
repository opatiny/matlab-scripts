%% Testing symbolic functions
clc; clear; close all;
clear all;
% when using symbolic equations, use clear all!!

%% define equation and solve it
syms x y

equ = x^2 + y^2 == 1;

[xSol, ySol] = solve(equ, [x,y])

%% simplify expressions
syms x;

f = cos(x)^2/(sin(x)-1);

simplify(f)

%% assume variable is in given subset
syms a integer;
assumptions % check the current assumptions

assume(a, 'positive'); % overwrite previous assumptions!!
assumptions

assumeAlso(mod(a,2)==0); % add assumptions
assumptions

%% derivative and integral
syms x;
% derivate the expression for x two times
diff2 = diff(x^3+3*x^2, x, 2)
diff1 = int(diff2, x);
original = int(diff1, x)
