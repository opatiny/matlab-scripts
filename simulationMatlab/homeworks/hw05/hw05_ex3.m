%% Assignment 5 - Exercise 3
clear; clc; close all;

% Mandelbrot set!!

%% variables
Z0 = 0;
C = -0.1 + 0.93*1i;

%% a) find when sequence diverges
minDiff = 5;
magZ = [abs(Z0)];
currentZ = Z0;
previousZ = Z0;
diff = 0;
iteration = 0;

while diff <= minDiff 
    currentZ = previousZ^2 + C;
    diff = abs(currentZ - previousZ);
    previousZ = currentZ;
    magZ = [magZ abs(currentZ)];
    iteration = iteration + 1;
    %  instead of this we could use a for loop and only add 1 to iteration
    %  when diff smaller than minDiff -> use logical operators!!
end

% plot
figure();
plot(magZ, 'x-');

fprintf('Number of iterations until divergence: %i\n', iteration);