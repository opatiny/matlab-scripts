%% Labo5 - Exercice 4: De-bruitage signal periodique
clc; clear; close all;

%% variables
f0 = 50; % Hz
fe = 5000; % Hz
T = 0.51; % s

T0 = 1/f0;
Te = 1/fe;

%% load data

data = load('4-SignalBruite.mat');
tt = data.t;
xn = data.xn;
N = length(xn);

Np = floor(N*Te/T0); % number of periods
N = Np*T0/Te; % redefine nb of samples to be a whole nb of periods
xcut = xn(1:N); % keep only part of signal

%% compute Fourier transform
Xjk = fft(xcut); % Xjk same length as xcut!!
df = fe/N; % frequential step
ff =  0: df : fe-df; % frequencies vector

% with shift
XjkShift = fftshift(Xjk);
ffShift = -fe/2:df:fe/2-df;

% unilateral spectrum
XjkUni = Xjk(1:N/2)/N; % we divide by N because this is X_D
ffUni = ff(1:N/2);

Ak = 2*abs(XjkUni);
Ak(end) = abs(XjkUni(end)); % DC component -> not multiplied by 2
Ak(1) = abs(XjkUni(1));

phik = angle(XjkUni);

%% automatic peak detection
threshold = max(Ak)/2; % arbitrary value for the threshold
indexes = find(Ak>threshold);
APeaks = Ak(indexes);
phiPeaks = phik(indexes);
fPeaks = ffUni(indexes);

%% reconstruct signal
A0 = Ak(1);
xrec = ones(1, length(xn))*A0;

for i=1:length(APeaks)
    xrec = xrec + APeaks(i)*cos(2*pi*fPeaks(i)*tt+phiPeaks(i));
end

%% computre rms and ratio
reconstructedStats = getSignalParameters(xrec);
noiseStats = getSignalParameters(xn-xrec);
% we could have used rms(xn)
% around -9.7 dB
signalNoiseRatio = 20* log10(reconstructedStats.rms/noiseStats.rms)
% interpretation: signal 10x stronger -> 20dB, signal 10x weaker-> -20dB
% we have a wide band noise -> le bruit est plus ou moins uniforme pour
% toutes les fréquences

%% compute filter to signal
% instead of choosing peaks
% we use the butter() function -> lowpass filter (you could make a high and
% bandpass too!!)
fc = 260; % Hz -> desired cutoff frequency

cutoffFreq = fc/(fe/2); % redefine cutoff frequency using Nyquist
order = 6; % order of the filters

[b, a] = butter(order, cutoffFreq);
[H,w] = freqz(b, a); % plot transfer function/ create plot data
Hf = tf(b,a,Te);

[b2, a2] = cheby1(order, 0.1, cutoffFreq);
[H2,w2] = freqz(b2, a2);
Hf2 = tf(b2,a2,Te);

f = w/pi*fe/2;

figure();
pzmap(Hf, Hf2); % plots poles and zeros of the transfer functions
title('Order 6 filters');
legend('Butterworth', 'Chebyshev');

%% apply filter to signal
xFilt = filtfilt(b, a, xn); %% filtfilt supprime le retard du au filtre

%% plot fft
figure();
subplot(3,1,1);
plot(tt, xn);
title('Original signal x[n]');
xlabel('time [s]');
ylabel('x[n]');
axis tight;
grid on;

subplot(3,1,2);
stem(ff, abs(Xjk));
title('fft(xn)');
xlabel('frequency [Hz]');
ylabel('|X[jk]|');
grid on;

subplot(3,1,3);
stem(ffShift, abs(XjkShift));
title('fftshift(xn)');
xlabel('frequency [Hz]');
ylabel('|X[jk] shifted|');
grid on;

%% plot unilateral spectrum
figure();
title('Unilateral spectrum');
subplot(2,1,1);
stem(ffUni, Ak); hold on;
% display selected peaks
plot(fPeaks, APeaks, 'rx');
% diplay threshold
plot([0, fe/2], [threshold, threshold], 'g');
hold off;
xlabel('frequency [Hz]');
ylabel('A_k [-]');
grid on;

subplot(2,1,2);
stem(ffUni, phik); hold on;
plot(fPeaks, phiPeaks, 'rx')
hold off;
xlabel('phase [rad]');
ylabel('phi_k');
grid on;

%% plot filtered signal
figure();
plot(tt, xrec);
title('Reconstructed signal');
xlabel('time [s]');
ylabel('xrec [n]');
axis tight;
grid on;

figure();
subplot(2,1,1);
plot(f, 20*log10(abs(H))); hold on;
plot(f, 20*log10(abs(H2)));
hold off;
title("Transfert functions of the filters order " + order);
xlabel('frequency [Hz]');
ylabel('|H(f)| [dB]');
legend('Butterworth', 'Chebyshev');
ylim([-100, 10]);
grid on;

subplot(2,1,2);
plot(tt, xn, 'b'); hold on;
plot(tt, xrec, 'g', 'LineWidth', 2);
plot(tt, xFilt, 'r', 'LineWidth', 2);
title('Comparison between xn, reconstructed and filtered with Butterworth');
xlabel('time [s]');
ylabel('Signals');
legend('x[n]', 'x_{rec}[n]', 'x_{filt}[n]');
axis tight;
grid on;



