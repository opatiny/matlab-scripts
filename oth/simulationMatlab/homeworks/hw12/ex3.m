%% Assignment 12 - Exercice 3
clear; clc; clf;

%% define function

v = linspace(-3,3,1000);
[X,Y] = meshgrid(v);

Z = sin(X).*cos(Y);

%% interpolate along circle
r = 2;

theta = 0:0.01:2*pi;
x1 = r*cos(theta);
y1= r*sin(theta);

zi = interp2(X,Y,Z,x1,y1);

%% plot
subplot(121);
contour(v,v,Z);
colormap('jet');
hold on;
circle(0,0,r);
hold off;

subplot(122);
plot(theta,zi);
grid on;
title('Function along circle');
xlabel('\theta [rad]');

