%% Labo2 - Ex 4: extract signal from noise
clc; clear; close all;

%% load data

data = load('signalbruite.mat');
time = data.time;
x = data.sn;

% compute sampling period : Te = 1ms
Te = time(2) - time(1);

%% auto-corellation

[rxx, lag] = mycorr(x, x);
% energy: W = 11308 [-]
% estimated period
T0 = 0.13; % [s]

%% plot auto-correlation
figure()
subplot(2,1,1);
plot(time, x, '.');
title('Signal with noise');
xlabel('t [s]');

subplot(2,1,2);
plot(lag*Te, rxx, '-.');
title('Auto-correlation');
xlabel('lags [s]');

%% estimated signal x_th
% hypothesis: signal is a sinusoid

tD = 0; % estimated phase in [s]
xTh = sin(2*pi/T0*(time-tD));

%% cross-correlation x_norm and x_th
% normalise x
xNorm = x/max(x);
[rxx2, lags2] = mycorr(xNorm, xTh);

%% plot cross-correlation x_norm and x_th
figure();
subplot(3,1,1);
plot(time, xNorm, '.');
title('Normalised signal x_{norm}');
xlabel('t [s]');
grid on;

subplot(3,1,2);
plot(time, xTh, '.');
title('Estimated signal x_{th}');
xlabel('t [s]');
grid on;

subplot(3,1,3);
plot(lags2*Te, rxx2, '-');
title('mycorr(x_{norm}, x_{th})');
xlabel('lags [s]');
grid on;
