%% Diffraction
clc; clear; close all;

%% Generate 2D plane
size = 0.05;
dxp = 0.0001; % pupil pixel size

[x,y] = meshgrid(-size:dxp:size);

matrixSize = length(x(1,:));

% square, circular or ring window

windowSize = 0.005; % mm
square = abs(x) <= windowSize & abs(y) <= windowSize;
circle = sqrt(x.^2 + y.^2) <= windowSize;
% the image of a point is smaller when the diameter increases!
ring = sqrt(x.^2 + y.^2) >= windowSize/2 & sqrt(x.^2 + y.^2) <= windowSize;
slot = abs(x) <= windowSize/10 & abs(y) <= windowSize;

window = ring;
TFR = abs(fftshift(fft2(window)));

middle = (matrixSize+1)/2;
halfSide = 50;

subMatrix = TFR(middle-halfSide:middle+halfSide, middle-halfSide:middle+halfSide);

figure(1);
subplot(2,1,1);
imagesc(window);
title('Diffraction window');
axis square;
subplot(2,1,2);
imagesc(subMatrix);
title('Image in the focal plane of an input parralel ray');
axis square;

%% frequency pixel size
dfp =  1/(matrixSize*dxp);
fmax = 1/dxp/2; % theoreme de Nyquist

%% transform frequency into position in focal plane
lambda = 0.55e-6; % wavelength in m
focal = 1; % focal distance in m

[fx,fy] = meshgrid(1:matrixSize,1:matrixSize);
fx = (fx-middle)*dfp;
fy = (fy-middle)*dfp;

u = fx*lambda*focal;
v = fy*lambda*focal;

%% plot slice of the intensity plot through the middle
figure(2);
plot(u(middle,:), TFR(middle,:));
title('Cut of the middle of the diffraction figure (intensity)')
grid on;

%% superimpose two rings/ windows
figure(3);
imagesc(TFR+circshift(TFR, [8,0]))
axis square;