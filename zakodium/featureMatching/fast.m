%% Detect FAST corners in an image
clc; clear; close all;

%% load image
image = imread('alphabet.jpg');
image = rgb2gray(image);

%% detect corners
corners = detectFastFeatures(image);

%% display results
imshow(image); hold on;
p = plot(corners.selectStrongest(50));
hold off;