%% Homework 11 - Exercise 2
% 2D Fourier transform
clc; clear; clf;

%% define grid
dimension = 1000;
holeSide = 3;
n = 20;
radius = 30;

maxValue = 1;


grid = zeros(dimension, dimension);

increment = 2*pi/n;
angleOffset = pi/2;

for angle = 0+angleOffset:increment:2*pi-increment+angleOffset
    centerRow = round(dimension/2 + radius*sin(angle));
    centerColumn = round(dimension/2 + radius*cos(angle));
    
    r = (holeSide-1)/2;

    grid(centerRow-r:centerRow+r, centerColumn-r:centerColumn+r) = maxValue;
end

contrastFactor = 10;
diffraction = fftshift(abs(fft2(grid)))*contrastFactor;

inverted = 255-diffraction;

%% plot
subplot(121);
imagesc(grid);
colormap("gray");
axis equal;
xlim([400,600]);
ylim([400,600]);

% compute diffraction image with fft2
subplot(122);
image(diffraction);axis equal;
colormap("gray");
xlim([0,1000]);
ylim([0,1000]);
