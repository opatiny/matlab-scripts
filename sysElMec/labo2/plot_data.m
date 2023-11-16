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


p_psi_ba = polyfit(alpha, psi_ba, 11);
psi_ba_model = polyval(p_psi_ba, alpha);

p_psi_bb = polyfit(alpha, psi_bb, 11);
psi_bb_model = polyval(p_psi_bb, alpha);

%% compute torques
p_W_der = polyder(p_Wmag);
coupleReluctant = polyval(p_W_der, alpha);

p_psi_ba_der = polyder(p_psi_ba);
coupleMutuel = polyval(p_psi_ba_der, alpha)*Ib;

p_psi_bb_der = polyder(p_psi_bb);
couplePropre = polyval(p_psi_bb_der, alpha)*Ib;


% couples en alpha = 0
startAngle = 5;
endAngle = 20;

Tem_aa = mean(coupleReluctant(startAngle:endAngle))*1e3
Tem_ba = mean(coupleMutuel(startAngle:endAngle))*1e3
Tem_bb = mean(couplePropre(startAngle:endAngle))*1e3

Tem = Tem_aa + Tem_ba + Tem_bb

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
ylabel('Flux totalisés propres et mutuels [wb]');

%% plot torques
figure();
plot(alpha, coupleReluctant, 'b-'); hold on;
plot(alpha, coupleMutuel, 'r-');
plot(alpha, couplePropre, 'g-');
grid on;
legend('Couple réluctant', 'Couple mutuel', 'Couple propre', 'Location', 'southwest');
xlabel('\alpha [°]');
ylabel('Couple [Nm]');
