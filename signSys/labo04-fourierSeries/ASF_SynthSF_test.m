%% Labo4 - Test ASF and SynthSF
clc; clear; close all;

%% test signals
T = 1;
F0 = 1;
Te = 0.02; % s
nn = 0:(T/Te-1);
tt = Te*nn;
% basic sinusoid
x1 = 2 + cos(2*pi*F0*nn*Te) + cos(2*pi*2*F0*nn*Te);

%% apply ASF
M = 5;
MM = -5:5;
Xjk = ASF(x1, tt, M);

module = abs(Xjk);
phaseDeg = angle(Xjk)*180/pi;

%% reconstruct x1 with SynthSF
xr = SynthSF(Xjk, F0, tt);

%% plots
figure();
subplot(4,1,1);
plot(tt, x1, '.');
title('x1 (sinusoid)');
xlabel('Time [s]');
grid on;

subplot(4,1,2);
stem(MM, module, '.');
title('ASF of x1 (module)');
xlabel('k [-]');
ylabel('Module of Xjk [-]');
grid on;

subplot(4,1,3);
stem(MM, phaseDeg, '.');
title('ASF of x1 (phase)');
xlabel('k [-]');
ylabel('Phase of Xjk [°]');
grid on;

subplot(4,1,4);
plot(tt, xr, '.');
title('Reconstruct x1 with SynthSF');
xlabel('time [s]');
grid on;