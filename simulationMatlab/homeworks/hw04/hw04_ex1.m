%% Assignment 4 - Exercise 1
clear; clc; close all;

%% variables

P1 = [1 0];
P2 = [-1 0];

X=-2:0.01:2;
[x,y]=meshgrid(X);

%% magnetic fields wires

[Hx1, Hy1] = magField(x,y,P1,1);
[Hx2, Hy2] = magField(x,y,P2,-1);

Hx = Hx1+Hx2;
Hy = Hy1+Hy2;

%% plot
streamslice(x,y,Hx,Hy);
axis equal;
xlabel('x');
ylabel('y');

%% function to compute magnetic field
% x0 and y0: meshgrid
% P: center point, where the wire goes through
% I: current
function [Hx, Hy] = magField(x0,y0,P,I)

x = x0 - P(1);
y = y0 - P(2);

r2 = x.^2 + y.^2;
Hnorm = I./(2*pi*r2);

Hx = -Hnorm.*y;
Hy = Hnorm.*x;
end

