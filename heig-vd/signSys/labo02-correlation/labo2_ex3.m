%% Labo2 - Ex 3: auto-correlation
clc; clear; close all;

%% generate sie
T0 = 0.5; % [s]
tau = 0.1; % [s]
A = 1; % [V]
Te = 0.01; % [s]
length = 10; % [s]

N = length/Te+1;

tt = linspace(0,length,N);
expSignal = A*sie(tt, T0, tau);

%% compute auto-correlation sie
[sieRxx, sieLag] = mycorr(expSignal, expSignal);
 % we see that the period is 0.5s,which corresponds 
 % to the truth
 % the energy is 111.328 [-] -> smaple 0
 
%% generate sinam
Tp = 0.05; % [s] 

sinamSignal = A*sinam(tt, T0, tau, Tp); 

%% compute auto-correlation sinam
[sinamRxx, sinamLag] = mycorr(sinamSignal, sinamSignal);
% the auto-correlation has a double oscillation, one is caused by the sinus
% repeating and one to the whole function periodicity
%% plots sie and sinam
figure();
subplot(4,1,1);
plot(tt, expSignal, '.-');
xlabel('t [s]')
title('Exponential signal x1[n]');

subplot(4,1,2);
plot(sieLag*Te, sieRxx, '.-');
xlabel('lags [s]')
title('Auto-correlation of x1[n]');

subplot(4,1,3);
plot(tt, sinamSignal, '.-');
xlabel('t [s]')
title('Sinam signal x2[n]');

subplot(4,1,4);
plot(sinamLag*Te, sinamRxx, '.-');
xlabel('lags [s]')
title('Auto-correlation of x2[n]');

%% two different sinuses
T1 = 1; % [s]
T2 = 1.1; % [s]
phase = 2; % [-]

sin1 = A*sin(2*pi/T1*tt);
sin2 = A*sin(2*pi/T2*tt);
sin3 = A*sin(2*pi/T1*tt+phase);

%% cross-correlation of sinuses
[sinFreqRxx, sinFreqLag] = mycorr(sin1, sin2);

[sinPhaseRxx, sinPhaseLag] = mycorr(sin1, sin3);

%% plot sinuses
figure();
subplot(2,1,1);
plot(tt, [sin1;sin2;sin3], '.-');
xlabel('t [s]')
title('3 sinuses');
legend('sin1: original sinus','sin2: different frequency', 'sin3: different phase');
grid on;

subplot(2,1,2);
plot(sinFreqLag*Te, [sinFreqRxx; sinPhaseRxx], '.-');
xlabel('lags [s]')
title('Cross-correlation of the sinuses');
legend('r_{sin1,sin2}', 'r_{sin1,sin3}');
grid on;