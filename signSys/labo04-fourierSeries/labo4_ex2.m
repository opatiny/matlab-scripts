%% Labo4 - Ex2: Butterworth filter
clc; clear; close all;

%% Load data
data = load('enreg_signaux2.mat');
xt = data.xtt;
tt = data.tt;
xT = data.xT;
tT = data.tT;
 
T0 = data.T0;
Te = data.Te;
 
Fe = 1/Te;
F0 = 1/T0;
M = 100;
 
Xjk = ASF(xT,tT, M);
% Xjk = Xjk(M+1:2*M+1); % make Xjk unilateral
 
%% Filtre H(n)
fnyq = 1/Te/2; fc = 4/T0 ; % caractéristiques du filtre
[num,den] = butter(4,fc/fnyq); % création des coefficients du filtre
H = tf(num,den,Te) % Création de la fonction de transfert et affichage

% pzmap(H);

% bode(H);

% calcul de H aux fréquences harmoniques
k = -M : M;
W = 2*pi*F0 * k ; % vecteur des pulsations normalisées des harmoniques bilatérales
[MagFk,PhaseFk] = bode(H,W);
MagFk = (squeeze(MagFk))';
MagFkdB = 20*log10(MagFk);
PhaseFk = (squeeze(PhaseFk))'-360;

freqArray = k * F0;

%% Plot Bode of the filter
figure();
subplot(2,1,1);
plot(freqArray, MagFkdB, '*-');
title('Bode d''amplitude');
xlabel('f [Hz]');
ylabel('|H| [dB]');
xlim([0,15000]);
grid on;

subplot(2,1,2);
plot(freqArray, PhaseFk, '*-');
title('Bode de phase');
xlabel('f [Hz]');
ylabel('Arg(H) [°]');
xlim([0,15000]);
grid on;

%% Apply filter to signal

Yjk = Xjk .* MagFk .* exp(1i*PhaseFk/180*pi);

moduleXjk = abs(Xjk);
moduleYjk = abs(Yjk);

phaseXjk = unwrap(angle(Xjk))/pi*180;
phaseYjk = unwrap(angle(Yjk))/pi*180;


%% Synthetize filter output
M40 = 13; % last value of MagFkdB attenuated less than 40dB
k40 = 2*M40+1;

yT = SynthSF(Yjk, F0, tT);
yt = SynthSF(Yjk, F0, tt);

yt_filter = filter(num, den, xt);
yT_filter = filter(num, den, xT);

%% Plot Xjk and Yjk and reconstructed signal
figure();
subplot(2,2,1);
stem(k, moduleXjk); hold on;
stem(k, moduleYjk, '*')
hold off;
title('Spectre d''amplitude');
xlabel('k [-]');
ylabel('Amplitude [-]');
legend('|Xjk|', '|Yjk|')
xlim([0,100]);

subplot(2,2,2);
stem(k, phaseXjk); hold on;
stem(k, phaseYjk, '*');
hold off;
title('Spectre de phase');
xlabel('k [-]');
ylabel('Phase [°]');
legend('Arg(Xjk)', 'Arg(Yjk)')
xlim([0,100]);

subplot(2,2,3);
plot(tT, xT); hold on;
plot(tT, yT, '-');
plot(tT, yT_filter, '.');
hold off;
title('Reconstructed signal (1 period)');
xlabel('Time [s]');
ylabel('Amplitude [-]');
legend('xT', 'yT', 'yT_{filter}')

subplot(2,2,4);
plot(tt, xt); hold on;
plot(tt, yt, '-');
plot(tt, yt_filter, '.');
hold off;
title('Reconstructed signal (whole)');
xlabel('Time [s]');
ylabel('Amplitude [-]');
legend('xt', 'yt', 'yt_{filter}')

%% Energy and power of xT and yT

xStats = getSignalParameters(xt)
yStats = getSignalParameters(yt)