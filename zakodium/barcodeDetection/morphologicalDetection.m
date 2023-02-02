%% Detect barcode locations in an image
clc; clear; close all;

%% Load test image and convert to gray
image1 = imread('23424-whiteBackground.png');
image2 = imread('25601-randomBackground.png');
image3 = imread('31781-qrCode.png');
image4 = imread('40328-verticalBarcode.png');

image = image4;
image = rgb2gray(image);

%% gradients

[gradientX, gradientY] = imgradientxy(image, 'prewitt');

% imshowpair(abs(gradientX), abs(gradientY), 'montage')

gradient = abs(gradientX - gradientY);

% imshowpair(image, gradient, 'montage');

%% convert to binary
%image = 255-gradient; % use a threshold of 100 if this is used
blurred = imgaussfilt(image, 3);
bw = imbinarize(blurred, 0.3);
imshowpair(blurred, bw, 'montage')

SE = strel('rectangle',[35,5]);
close = imclose(bw, SE);

montage({image, bw, close}, 'Size', [1 3])
