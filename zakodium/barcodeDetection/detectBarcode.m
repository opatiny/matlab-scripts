%% Detect barcode locations in an image
clc; clear; close all;
% code based on https://ch.mathworks.com/help/vision/ug/localize-and-read-multiple-barcodes-in-image.html

%% Load test image
image1 = imread('23424-whiteBackground.png');
image2 = imread('25601-randomBackground.png');
image3 = imread('31781-qrCode.png');
image4 = imread('40328-verticalBarcode.png');

image = image4;
image = rgb2gray(image);

%% Detect MSER features.
[~, cc] = detectMSERFeatures(image);

% Compute region properties MajorAxisLength and MinorAxisLength.
regionStatistics = regionprops(cc, 'MajorAxisLength', 'MinorAxisLength');

% Filter out components that have a low aspect ratio as unsuitable
% candidates for the bars in the barcode.
minAspectRatio = 10;
candidateRegions = find(([regionStatistics.MajorAxisLength]./[regionStatistics.MinorAxisLength]) > minAspectRatio);

% Binary image to store the filtered components.
BW = false(size(image));

% Update the binary image.
for i = 1:length(candidateRegions)
    BW(cc.PixelIdxList{candidateRegions(i)}) = true;
end

% Display the binary image with the filtered components.
imshow(BW);
montage({image, BW})
title("Candidate regions for the barcodes")