%% Labo5 - Exercice 2: Filtrage domaine fréquentiel
clc; clear; close all;

%% Generate square wave
f0 = 100; % [Hz]
T0 = 1/f0;
length = 1; % [s]
fe = 20000; % [Hz]
Te = 1/fe;
nb_period = 10;

N = length*fe;
tt = (0:N-1)*Te;
xt = sign(sin(2*pi*tt*f0));

% play signal
% soundsc(xt,fe);

%% compute spectrum
Xjf = fftshift(fft(xt)/N);
df = fe/N;
ff = -fe/2:df:fe/2 - df;

%% filter high frequencies
size(Xjf)
Xjf_f = Xjf;
freqThreshold = 550; % [Hz]
index = find(ff>freqThreshold,1)
indexLowTrim = N-index
Xjf_f(index:N) = 0;
Xjf_f(1:N-index) = 0;

%% reconstruct signal
xt_f = real(ifft(fftshift(Xjf_f * N)));

% play signal
 % soundsc(xt,fe);
soundsc(xt_f,fe);

%% plot data
figure();
subplot(2,2,1);
plot(tt,xt);
title('Square signal x(t) (ten periods)');
xlabel('time [s]');
xlim([0,10*T0]);
grid on;

subplot(2,2,2);
plot(ff,abs(Xjf));
title('Fourier transform of x(t)');
xlabel('f [Hz]');
xlim([-2000,2000]);
grid on;

subplot(2,2,3);
plot(tt,xt_f);
title('Filtered signal (ten periods)');
xlabel('time [s]');
xlim([0,10*T0]);
grid on;

subplot(2,2,4);
plot(ff,abs(Xjf_f));
title('Trimmed FT of x(t)');
xlabel('f [Hz]');
xlim([-2000,2000]);
grid on;
