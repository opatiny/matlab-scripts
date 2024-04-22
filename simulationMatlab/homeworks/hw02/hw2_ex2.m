%% Homework 2 - Exercice 2
clear; clc; close all;

% we want to draw lissajoux figures

%% compute figures
nbPlots = 4;
a = [1 2 3 4]';
b = [2 3 4 5]';

delta = 0;
A = 1;
B = 1;

t = 0:0.01*pi:2*pi;

x = A*sin(a.*t + delta);
y = B*sin(b.*t);

%% plot
figure();
for i = 1:nbPlots
    subplot(2,2,i);
    plot(x(i, :), y(i, :), '-');
    axis equal;
    title(['frequency ratio ', num2str(a(i,1)), '/', num2str(b(i,1))]);
end




