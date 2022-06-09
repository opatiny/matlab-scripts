%% Example: linear regression
clc; clear; close all;

%% variables

y = [0,2,5,4,6,7,8,6,9,10];
x = 1:10;

%% linear regression

p = polyfit(x,y,1);
line = polyval(p, x);

%% plot
figure();
plot(x,y, '.'); hold on;
plot(x, line, 'r');
hold off;
title('A linear regression');
xlabel('x');
ylabel('y');
grid on;
