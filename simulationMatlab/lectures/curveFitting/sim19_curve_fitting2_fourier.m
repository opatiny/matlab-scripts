%% Curve fitting 2: periodic functions 
clear,clc
format compact

% signal
f1 = 50;    % 1. harmonic [Hz]
w=2*pi*f1;
T=1/f1;     % period 
f = @(t) .5 + 2*sin(2*w*t) - 3*cos(3*w*t);

% plot
figure(1),clf
fplot(f,[0,T],'DisplayName','signal')
hold on, grid on, legend

% n sampling points
n=8;        % sample points
ts=T/n;     % sampling time
t=(0:n-1)*ts;   % discrete time  
y=f(t);         % discrete data
plot(t,y,'o','DisplayName','sampling points')

%% Fourier coefficients from regression
% approximation functions do not have to be polynomials
A=[t'.^0, cos(2*w*t'), sin(2*w*t'), cos(3*w*t'), sin(3*w*t')];
% find fourier coefficients with RMS minimal error
a=A\f(t')

%% Fourier coefficients from integral
display('trapz')
addpath('./assignments');
y1=[y,y(1)]; t1=[t,T];              % add data point for integral
[a0,fn,an,bn] = fanalysis(t1,y1,3);  % assignment 7.1
an
bn

display('integral')
a3=2/T*integral(@(t) f(t).*cos(3*w*t),0,T)
b2=2/T*integral(@(t) f(t).*sin(2*w*t),0,T)

%% Fourier coefficients from fft (fast Fourier transform)
% caution: provide exactly one period!!

F=fft(y)/n;     % normalized DFT (discrete Fourier transform)

figure(2)
stem(abs(F))
% the second half of the spectrum is a copy of the first half
% this corresponds to positive and negative frequencies in the complex spectrum
k=floor(-(n-1)/2):floor((n-1)/2);   % n integer samples (floor considers even/odd n) 
freq=k/T;                           % min frequeny (1/T) to max frequency (fs/2)
                                    % fs=1/ts;      sampling frequency
                                    % Nyquist-Shannon sampling theorem

% to plot the spectrum with negative frequencies fftshift() is helpful
figure(3),clf
% magnitude of complex spectrum
stem(freq,fftshift(abs(F)))
xlabel('frequency')
grid on

% complex fourier coefficients -> real fourier coefficients
a0=F(1)                       % mean (DC)
an=2*real(F(2:ceil(n/2)))     % cos amplitude
bn=-2*imag(F(2:ceil(n/2)))    % sin amplitude

%% For the sake of convenience, I have included all steps in a function
[A0,fn,An] = fftanalyse(y,ts)

%% adding one more data point will affect signal and the result
[A0,fn,A] = fftanalyse( [y y(1)],ts)

%% exercise 19.1
% try to extract the frequencies in the signal y(t) with fftanalyse()

clear,clc
format compact
% signal
f1 = 50;    % 1. harmonic [Hz]
w=2*pi*f1;
T=4/f1;     % period, change the factor to modify nb of periods
f = @(t) .5 + 2*sin(2*w*t) - 3*cos(3*w*t);

% plot
figure(1),clf
fplot(f,[0,T],'DisplayName','signal')
hold on, grid on, legend

% n sampling points
n=20;           % sample points
ts=T/n;         % sampling time
t=(0:n-1)*ts;   % discrete time  
y=f(t);         % discrete data
plot(t,y,'o','DisplayName','sampling points')

% how many sampling points do you need at least?
% How does the result differ if you provide more periods of the signal?

[A0,freq,A] = fftanalyse(y,ts)

figure
stem(freq,A)
xlabel('frequency [Hz]');
ylabel('amplitude');
grid on;

% at least 2x the nb of the highest harmonic per period
% minNbPoints = 2 * maxHarmonicNb * nbPeriods



%% example: analyze noisy data

clear,clc,close all
ts=0.001;       % sampling time
n = 2^10;       % 1024 sampling points
t = 0:ts:(n-1)*ts;
x = 1.5+2*sin(2*pi*50*t)+sin(2*pi*120*t);
% add noise
xr = x + randn(size(t));

subplot(211),plot(t,xr);
xlabel('time / s')
title('Signal in time domain')

[a0,freq,amp] = fftanalyse( xr,ts);
fprintf('DC signal %f\n',a0)

% plot continous spectrum
subplot(212),plot(freq,amp)
xlabel('Frequenz')
ylabel('Amplitude')
title('Signal in frequency domain')
% we can see the base frequencies that we put in the signal

%% exercise 19.2
% In array sunspot you find the number of sunspots, 
% measured between 1700 to 1987 . 
% Plot this data in time and frequency domain
% and calculate the period of solar activity.
clear,clc,clf
load sunspot.dat
t = sunspot(:,1);
data = sunspot(:,2);

subplot(211),plot(t,data);
xlabel('time [year]')
title('Sun activity in time domain')

ts = t(2)-t(1);

[a0,freq,amp] = fftanalyse(data,ts);

subplot(212),plot(freq,amp)
xlabel('Frequency [1/year]')
ylabel('Amplitude')
title('Sun activity in frequency domain')

maxAmpIndex = find(amp == max(amp));
sunFreq = freq(maxAmpIndex);
sunPeriod = 1/sunFreq;

fprintf('Sun activity period: %.0f years\n', sunPeriod)

%% Aliasing due to too small sampling rate
% aliasing is when we sample at a specific frequency that completely modify
% what the reconstructed signal is like
% it happens when the nyquist theorem is not respected
% min_fs = 2*max_f;
% tone frequency rises in 2s from 100Hz to 8000Hz
clear,clf

f0=100;               % initial frequency
f1=8000;              % final frequency
tend = 2;             % final time 
SR = 44000;           % high sampling rate (CD)
t = 0:1/SR:tend;      % time
sig=chirp(t,f0,tend,f1);
% play
sound(sig/10,SR)
% plot first part of signal
n=2000;
plot( t(1:n), sig(1:n) )


% reduce sampling rate
SR = 8000;            % sampling rate
t = 0:1/SR:tend;      % time
sig=chirp(t,f0,tend,f1); % frequency increases with time
% play
sound(sig/10,SR)

% Aliasing in optics: wheels turn backwards in movie 
% https://www.youtube.com/watch?v=SFbINinFsxk

%% compare DFT, FFT
clear,clc

% 16381 random data points
N=prevprime(2^14);           
x=rand(1,N);

% DFT
tic
n=0:N-1;
w=2*pi*n'/N;
Xdft = x*exp(-1j*w*n);
toc

% FFT
tic
Xfft=fft(x);
toc

% The FFT algorithm is comparatively slow when the number of data corresponds to a prime number. 
% The FFT algorithm is particularly fast when the number of data corresponds to a power of two. 
% Padding the signal with zeros can speed up the calculation.
n = pow2(nextpow2(length(x)));  % 16384
tic
fft(x,n);
toc

% verify if DFT = FFT
max(abs(Xfft-Xdft)) % maximum deviation

%% enjoy: FFT of unit matrix
clear,clf
for i=1:9
    subplot(3,3,i)
    plot(fft(eye(i)))
    axis equal
end
