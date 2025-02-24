%% Homework 2 - Exercice 4
clear; clc; close all;

nbSides = [5 7 9 11];
radius = 1;

figure();

%% compute vertices and perimeter and plot

for i=1:length(nbSides)
    sides = nbSides(i);

    angles = 0:2*pi/sides:2*pi;

    x = radius*cos(angles);
    y = radius * sin(angles);

    shape = polyshape([x' y']);

    perim = perimeter(shape);

    subplot(2,2,i);
    plot(x,y, '-');
    axis equal;
    title(['perimeter of polygon with ', num2str(i), ' sides is ', num2str(perim)]);
end