%% Techmes - TE2 - Ex2

clc; clear; close all;

%% load data
data = importdata('data/tempe.txt');
time = data(:,1);
temperature = data(:,2);

%% plot raw data
figure();
plot(time, temperature);
axis tight;
title('Données brutes');

%% compute linerized data
% we find that ln(T) = ln(K) - apha*t, we just have to take the log of the
% temperature to have something linear.
lin = log(temperature);

% linear regression

p = polyfit(time, lin, 1)
line = polyval(p, time);

%% plot linerized data
figure();
plot(time, lin, 'b.-'); hold on;
plot(time, line, 'r');
hold off;
axis tight;
legend('data linéarisé', 'régression linéaire');
title('Données linéarisées');

%% reconstruct exponential fit

slope = p(1);
offset= p(2);
K = exp(offset)
alpha = -slope

expFit = K*exp(-alpha*time);

%% plot raw data and exponential fit
figure();
plot(time, temperature); hold on;
plot(time, expFit, 'r');
hold off;
axis tight;
grid on;
title('Données brutes et modèle exponentiel');
legend('données brutes', 'fit exponentiel');
