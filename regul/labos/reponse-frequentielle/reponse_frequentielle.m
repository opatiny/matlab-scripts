%% Reponse frequentielle experimentale
clear; clc; close all;
init_path_MEE;

%% Variables
fe = 1000; % sampling freq in [Hz]
Te = 1/fe;
Ns = 1000; % nb of points by period [-]
f = fe/Ns;
T = 1/f;
nbPeriods = 10; % [-]

%% create signal
tt = 0:Te:nbPeriods*T-Te;
A = 1;
offset = 0; % [V]

% sinusoid
sinusoid = A*sin(2*pi*tt*f);

% square
square = A*square(2*pi*tt*f) + offset;
% la fft permet de trouver directement la valeur de l'offset

% SBPA (suite binaire pseudo aleatoire)

%% pick only last period of input signal (precisely!)
% pick the desired signal
u = square;
% because there could be a transient response
uN = u(end-Ns+1:end);
tN = tt(end-Ns+1:end);
N = length(tN);

%% fast fourier transform
UN = fftshift(fft(uN)/N);

% frequency vector
if mod(N,2)==0
    fN = (-1/2:1/N:1/2-1/N)*fe;
else
    fN = ((0:N-1)-(N-1)/2)/N*fe;
end

%% simulation of the system
% transfert function
K = 1.3;
zeta = 0.01;
wn = 80;
jw = tf('s');
H = K/(1+jw*2*zeta/wn + (jw/wn)^2);

%% insert input signal in system
% simulated response of the system
y = lsim(H,u,tt); % output
% extract last period
yN = y(end-Ns+1:end);
% Fourier transform
YN = fftshift(fft(yN)/N);

%% experimental and theoretical frequential responses
[AEst, phiEst, omegaEst] = affiche_FFT_bode(fN, [UN(:), YN(:)]);
[A, phi, omega] = bode(H);
A = A(:);
phi = phi(:);

%% plot signal
figure();
subplot(2,3,1);
stem(tt, y); hold on;
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
semilogx(omegaEst, 20*log10(AEst), 'x', omega, 20*log10(A));
grid on;
xlabel('\omega [rad/s]');
ylabel('A(\omega)');

subplot(2,3,4);
stem(tt, u); hold on;
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

% figure();
% step(H); % response to an impuslion -> shows transient phase

% figure();
% bode(H);

% figure();
% lsim(H,u,tt)
