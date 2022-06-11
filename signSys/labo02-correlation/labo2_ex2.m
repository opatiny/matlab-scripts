%% Labo2 - Ex 3: xcorr
clc; clear; close all;

%% variables
x = [1,1,0,0,0,0,0,0,0,0];
y = [0,0,2,2,0,0,0,0];
 
%% compute correlations
[myrxy, mylag] = mycorr(x,y)
[rxy, lag] = xcorr(y,x)

%% plot
figure();
subplot(4,1,1);
stem(1:length(x),x);
title('x')

subplot(4,1,2);
stem(1:length(y), y);
title('y');

subplot(4,1,3);
stem(mylag, myrxy);
title('rxy[lag] = mycorr(x,y)');

subplot(4,1,4);
stem(lag, rxy);
title('rxy[lag] = xcorr(y,x)');

 