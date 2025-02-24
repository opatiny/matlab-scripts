%% Assignment 3 - Exercise 1
clear; clc; close all;

%% a)
data = load('hw03_data.txt');
t = data(:, 1);
y = data(:, 2);

%% b)
y0 = sin(t) .* t / 5;

%% c)
y1 = 1 + t/5;

indices = y > y1;

red = data(indices, :);

%% plot
figure();
plot(t, y, 'k.', 'MarkerSize', 10); hold on;
plot(t,y0, 'b-');
plot(t, y1, 'g-');
plot(red(:,1), red(:,2), 'r.', 'MarkerSize', 10);
hold off;

%% d)
length(indices)
keepData = data;
keepData(indices, :) = [];

keepY1 = y1;
keepY1(indices) = [];

keepY0 = y0;
keepY0(indices) = [];

diff = abs(keepData(:,2)-keepY0);
index = find(diff == max(diff))

%% plot
figure();
plot(keepData(:,1), keepData(:,2), 'b.', 'MarkerSize', 10); hold on;
plot(t, y0, 'b-');
plot(keepData(index,1), keepData(index,2), 'ro');
hold off;
