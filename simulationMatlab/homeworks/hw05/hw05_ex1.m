%% Assignment 5 - Exercise 1
clear; clc; close all;

%% Variables
Uq = 1; % V
Zi = 1+1j; % Ohm

%% Compute real power
N = 500;
R = linspace(0,4,N);
X = linspace(-3.5,2,N);

[x, y] = meshgrid(R, X);

Zv = x + y*1j;

% Ohm: U = ZI
Ztot = Zi + Zv;
I = Uq./Ztot;

% dissipated power
S = 1/2*Zv .* abs(I).^2;

P = real(S);

%% Find maximum
% this is not a good solution, we should look for the minimum of the
% function instead
[maxPower,index] = max(P, [], 'all','linear');
[yMax, xMax] = ind2sub(size(P),index);

Zvmax = R(xMax)+ 1i* X(yMax)
%% plot
figure();
contour(x,y,P, 100, '.-'); hold on;
plot(R(xMax), X(yMax), 'bx')
hold off;
colorbar; colormap('jet');
xlabel('Resistance [\ohm]');
ylabel('Reactance [\ohm]');
title(['P_{max} = ' num2str(maxPower) ', Z_v = ' num2str(Zvmax)]);