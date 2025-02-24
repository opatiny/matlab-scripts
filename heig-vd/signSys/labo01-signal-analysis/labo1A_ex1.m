%% Labo 1A - Ex1: Sampling
clc; clear; close all;

%% Variables

A = 1; % [-]

% in seconds
T0 = 1e-3;
tmin = 0;
tmax = 20e-3;
dt = 20e-6;

%% "Analog" signal

tt = tmin:dt:tmax-dt; % -dt car on part de 0
xt = A*sin(2*pi*tt/T0);

%% fe = 4000Hz
fe1 = 4e3;
Te1 = 1/fe1;
tt1 = tmin:Te1:tmax-Te1;
sampling1 = A*sin(2*pi*tt1/T0);

%% fe = 2000Hz
fe2 = 2e3;
Te2 = 1/fe2;
tt2 = tmin:Te2:tmax-Te2;
sampling2 = A*sin(2*pi*tt2/T0);

%% fe = 1100Hz
fe4 = 1.1e3;
Te4 = 1/fe4;
tt3 = tmin:Te4:tmax-Te4;
sampling3 = A*sin(2*pi*tt3/T0);

%% fe = 900Hz
fe4 = 0.9e3;
Te4 = 1/fe4;
tt4 = tmin:Te4:tmax-Te4;
sampling4 = A*sin(2*pi*tt4/T0);

%% Plot
figure();
subplot(5,1,1);
title('fe = 4kHz');
plot(tt,xt, 'b.');
xlabel('time [s]');
xlim([-10*dt, tmax+10*dt]);

subplot(5,1,2);
plot(tt1,sampling1, 'b.-');
xlabel('time [s]');

subplot(5,1,3);
% here we have a sampling problem!! 
% -> always evaluating when function is 0
plot(tt2,sampling2, 'r+-', tt, xt, 'b.-');
xlabel('time [s]');

subplot(5,1,4);
plot(tt3,sampling3, 'r+-', tt, xt, 'b.-');
xlabel('time [s]');

subplot(5,1,5);
plot(tt4,sampling4, 'r+-', tt, xt, 'b.-');
xlabel('time [s]');

% Shannon's theorem: the min sampling frequency in twice the frequency of
% the signal