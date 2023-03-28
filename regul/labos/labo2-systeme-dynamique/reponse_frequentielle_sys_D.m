%% Reponse frequentielle: diagramme de Bode
clear; clc; close all;
init_path_MEE;

%% import data
file = load('./data/SBPA_sys_D.mat');

Ns = file.Ns;
Np = file.Np;
R = file.R;
h = file.h;

u = file.data(:,1); % commande
y = file.data(:,2); % grandeur reglee mesuree
t = file.t;

fe = 1/h;

%% pick only last period of input signal (precisely!)
% because there could be a transient response
uN = u(end-Ns+1:end);
yN = y(end-Ns+1:end);
tN = t(end-Ns+1:end);
N = length(tN);

%% fast fourier transform
UN = fftshift(fft(uN)/N);
YN = fftshift(fft(yN)/N);

%% create frequency vector
if mod(N,2)==0
    fN = (-1/2:1/N:1/2-1/N)*fe;
else
    fN = ((0:N-1)-(N-1)/2)/N*fe;
end

%% simulation of the system
data = load('exports/H_sys_D');
H = data.H;

%% experimental and theoretical frequential responses
[AEst, phiEst, omegaEst] = affiche_FFT_bode(fN, [UN(:), YN(:)]);
[A, phi, omega] = bode(H);
A = A(:);
phi = phi(:);
phi = wrap(phi, 180);

%% plot signal
figure();
subplot(2,3,1);
stem(t, y); hold on;
stem(tN, yN, 'r');
hold off;
grid on;
xlabel('time [s]');
ylabel('y(t)');

subplot(2,3,2);
stem(fN, abs(YN));
grid on;
xlabel('frequency [Hz]');
ylabel('|Y_N|');

subplot(2,3,3);
semilogx(omegaEst, 20*log10(AEst), '.'); hold on;
semilogx(omega, 20*log10(A), '-');
hold off;
grid on;
xlabel('\omega [rad/s]');
ylabel('A(\omega) [dB]');

subplot(2,3,4);
stem(t, u); hold on;
stem(tN, uN, 'r');
hold off;
grid on;
xlabel('time [s]');
ylabel('u(t)');

subplot(2,3,5);
stem(fN, abs(UN));
grid on;
xlabel('frequency [Hz]');
ylabel('|U_N|');

subplot(2,3,6);
semilogx(omegaEst, phiEst, '.'); hold on;
semilogx(omega, phi, '-');
hold off;
grid on;
xlabel('\omega [rad/s]');
ylabel('\phi(\omega) [°]');

