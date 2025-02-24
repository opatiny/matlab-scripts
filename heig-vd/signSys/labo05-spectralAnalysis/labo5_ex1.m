%% Labo5 - Exercice 1: Transformée de Fourier
clc; clear; close all;

%% Generate square signal
N = 1000;
A = 1;
delta_t  = 11; % [s]
Te = 1; % [s]

tt = linspace(-N/2,N/2-1, N);

xn = [zeros(1,N/2-(delta_t-1)/2), A*ones(1,delta_t), zeros(1,N/2-(delta_t-1)/2-1)];

%% Plot square signal
figure();
stem(tt,xn);
title('Square signal x(t)');
xlabel('time [s]');
grid on;

%% Theoretical Fourier transform Xth
% Here f should be a ocntinuous function, this is however impossible in
% matlab, so we just define a large nb of points to plot.
fmin = -1;
fmax = 1;

nbPoints = 3000;

f_continuous = linspace(fmin, fmax, nbPoints);

Xth = A*delta_t*sinc(f_continuous*delta_t);

figure();
plot(f_continuous, Xth, '.-');
title('Theoretical Fourier transform of x(t)');
grid on;

%% Fourier transform of the discrete signal

% df ist the spectral resolution
df = 1/(4*delta_t); % we chose this value to have points where the function is zero
           % we could have chosen any multiple of delta_t

n = 0:(N-1); % sample index

nbK = (fmax-fmin)/df;
k = -nbK/2:nbK/2-1; % frequency index

f = k*df;

% k and n can be different if using dot product, but they must be the same
% when using fft()

W = exp(-1i*2*pi*n'*Te*f); % le df se simplifie!

Xd = xn*W;
Xjk = Te*Xd;

moduleXth = abs(Xth);
moduleXjk = abs(Xjk);

%% Using fft()
Fe= 1/Te;
Xfft = fftshift(Te*fft(xn));

moduleXfft= abs(Xfft);

df1 = Fe/N;
ff = -Fe/2:df1:Fe/2-df1;

%% Plot FT
figure();
plot(f,moduleXjk, '.-'); hold on;
plot(f_continuous,moduleXth, '-');
plot(ff,moduleXfft, '.-');
hold off;
title('Fourier transform of the discrete signal');
legend('Xjk', 'Xth', 'Xfft');
xlabel('f [Hz]');



