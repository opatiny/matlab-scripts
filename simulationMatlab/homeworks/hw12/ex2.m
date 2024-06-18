%% Assignment 12 - Exercice 2
clear; clc; clf;

%% keys and layout
fy = [697, 770, 852, 941];
fx = [1209, 1336, 1447];
keys = ['1' '2' '3'
        '4' '5' '6'
        '7' '8' '9'
        '*' '0' '#'];

%% load data
data = load('hw12_MFV.mat');

y = data.y;
fs = data.fs;
ts = 1/fs;

t = 0:ts:(length(y)-1)*ts;

%% make noise

% sound(y,fs);

%% find when keys are pressed
threshold = 0.2;

smooth = movmean(abs(y),100);

keysPressed = smooth > threshold;

transitions = find(diff(keysPressed));

transitionTimes = transitions*ts;

indices = reshape(transitions,2,[])';
nbKeys = length(indices(:,1));

%% find frequencies of each key
text = '';
for i = 1:nbKeys
    startIdx = indices(i,1);
    endIdx = indices(i,2);
    signal = y(1,startIdx:endIdx);
    [A0,fn,An] = fftanalyse(signal,ts);

    % figure(1);
    % plot(fn,An);
    % title('Fourier transform');
    % ylabel('Amplitude');
    % xlabel('Frequency [Hz]');

    maxAmplitudes = maxk(An, 2);

    f1 = fn(find(An == maxAmplitudes(1)));
    f2 = fn(find(An == maxAmplitudes(2)));

    [~, col] = min(abs(fx-f1));
    [~, row] = min(abs(fy-f2));

    key = keys(row, col);
    text = strcat(text, key);
end

fprintf('The sequences of keys is: %s\n', text);

%% plot
figure(2)
subplot(211);
plot(t,y,'-');
xlabel('Time [s]');
ylabel('Amplitude');

subplot(212);
plot(t,smooth,'-');
hold on;
yline(threshold, 'r');
plot(transitionTimes, threshold*ones(1,length(transitions)), 'ro');
hold off;
xlabel('Time [s]');
ylabel('Amplitude');
