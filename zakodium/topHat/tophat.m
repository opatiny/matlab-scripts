%% Test the tophat algorithm
clear; clc; close all;

%% Load image
screws = imcomplement(im2gray(imread('./images/screws.jpg')));
rice = im2gray(imread('./images/rice.png'));

image = screws;
figure();
imshow(image);

%% Process
disk = strel('disk',50);

rectangle = strel('rectangle', [101,101]);

se = rectangle;

tophatFiltered = imtophat(image,se);

figure();
imshow(tophatFiltered)