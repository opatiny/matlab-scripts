%% Plot des donnees simulees par elements finis
clear; clc; close all;

%% variables
Ib = 1; % A

%% load data
data = readtable('data.csv');

alpha = data.alpha;
WmagPrime = data.WmagPrime;
psi_ba = data.psi_ba;
psi_bb = data.psi_b - data.psi_ba;

%% find polynomial models
p_Wmag = polyfit(alpha, WmagPrime, 11);
WmagPrime_model = polyval(p_Wmag, alpha);


p_psi_ba = polyfit(alpha, psi_ba, 4);
psi_ba_model = polyval(p_psi_ba, alpha);

p_psi_bb = polyfit(alpha, psi_bb, 4);
psi_bb_model = polyval(p_psi_bb, alpha);

%% compute torques
coupleReluctant = polyder(p_Wmag);

%% plot results
figure();
plot(alpha, WmagPrime, 'bo'); hold on;
plot(alpha, WmagPrime_model, 'b-');
grid on;
xlabel('\alpha [°]');
ylabel('W''_{mag} [J]');

figure();
plot(alpha, psi_bb, 'ro'); hold on;
plot(alpha, psi_ba, 'bo');
plot(alpha, psi_bb_model, 'r-');
plot(alpha, psi_ba_model, 'b-');
hold off;
legend('\Psi_{bb}', '\Psi_{ba}', 'Location', 'southwest');
grid on;
xlabel('\alpha [°]');
ylabel('Flux propres et mutuels [wb]');