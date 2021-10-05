%% HES d'été Matlab - Exo 7 
clc; clear; close all;

%% Données :
N = 20;
f = 100;
T = 1/f;
A = 10;
phi = pi/2;
nbrTime = 1000;

%% Création d'un signal carré
time = linspace(-2*T,2*T,nbrTime);
square = A*square(2*pi*f*time+phi);

%% Décomposition en série Fourier
A0 = 0;
X = zeros(1,length(N));
K = zeros(1,length(N));
for k=1:N
    % no need to make an if for zero because handled in sinc()
    K(1,k) = k;
    X(1, k) = A * sin(k*pi/2)/(k*pi/2);
end

Ak = 2 * abs(X);
alpha_k = angle(X);

%% Recompostion du signal
sinuses = zeros(N,length(time));
for currentIndex=1:N
    sinuses(currentIndex,:) = ...
            Ak(1,currentIndex)*...
            cos(2*pi*currentIndex*f*time + alpha_k(1,currentIndex));
end
recomposition = sum(sinuses);

%% Affichages
figure('Name','original square signal');
plot(time, square);
grid on;
title('f=100 [Hz], A = 10');
axis([-0.02 0.02 -11 11]) % scaling the plot
xlabel('t [s]');
ylabel('x(t)');

figure('Name', 'spectral components');
subplot(2,1,1);
bar(K,Ak);
title('Amplitude versus frequency');
xlabel('Index k [-]');
ylabel('Amplitude [-]');
grid on;

subplot(2,1,2);
stem(K, alpha_k, '.', 'MarkerSize', 12);
title('Phase versus frequency');
xlabel('Index k [-]');
ylabel('Phase [rad]');
grid on;

figure('Name', 'recomposition of the signal');
subplot(2,1,1);
plot(time, [recomposition; square]);
title('Recomposed signal');
ylabel('Amplitude [-]');
xlabel('Time [s]');
grid on;
subplot(2,1,2);
plot(time, sinuses);
title('Sinusoïdal components');
ylabel('Amplitude [-]');
xlabel('Time [s]');
grid on;

signal = zeros(1, length(time));
figure('Name', 'recomposition of the signal');
for k = 1:N
    plot(time, signal);
    title('Recomposed signal');
    ylabel('Amplitude [-]');
    xlabel('Time [s]');
    grid on;
    signal = signal + sinuses(k,:);
    pause(0.5); % in seconds
end
