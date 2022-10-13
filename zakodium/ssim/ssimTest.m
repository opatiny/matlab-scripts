%% Compute structural similarity for a few images
clc; clear; close all;

%% load images

ref = imread("ssim-original.png");
contrast = imread("ssim-contrast.png");
saltPepper = imread("ssim-saltPepper.png");
blurry = imread("ssim-blurry.png");
corrupted = imread("ssim-corrupted.png");

%% compute SSIM

[originalSsim, ~] = ssim(ref, ref) % 1
[contrastSsim, ~] = ssim(contrast, ref) % 0.8201
[saltPepperSsim, ~] = ssim(saltPepper, ref) % 0.7831
[blurrySsim, ~] = ssim(blurry, ref) % 0.7659
[corruptedSsim, ~] = ssim(corrupted, ref) % 0.7178
