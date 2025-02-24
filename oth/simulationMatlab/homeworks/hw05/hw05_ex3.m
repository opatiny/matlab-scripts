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
divergenceMatrix = 0;
nbIterations = 30;

for iterations=1:nbIterations 
    currentZ = previousZ^2 + C;
    diff = abs(currentZ - previousZ);
    previousZ = currentZ;
    magZ = [magZ abs(currentZ)];
    divergenceMatrix = divergenceMatrix + (diff < minDiff);
end

% plot
figure();
plot(magZ, 'x-');
xlim([0 divergenceMatrix+2]);

fprintf('Number of iterations until divergence: %i\n', divergenceMatrix);

%% b) calculte at which iteration it diverges for whole complex plane
div = 1000;
x = [-2,2];
y = x;

while 1
    re=linspace(x(1), x(2),div);
    im=linspace(y(1), y(2),div);
    [RE,IM] = meshgrid(re,im);
    % matrix of complex plane
    C = RE + 1i*IM;
    
    minDiff = 2;
    currentZ = Z0;
    previousZ = Z0;
    diff = 0;
    divergenceMatrix = 0;
    nbIterations = 50;
    
    for iterations=1:nbIterations
        currentZ = previousZ.^2 + C;
        diff = abs(currentZ - previousZ);
        previousZ = currentZ;
        divergenceMatrix = divergenceMatrix + (diff < minDiff);
    end
    
    % plot complex plane
    
    imagesc(re, im, divergenceMatrix);
    colormap('jet'); axis equal;
    colorbar;
    
    [x,y] = ginput(2);
end
