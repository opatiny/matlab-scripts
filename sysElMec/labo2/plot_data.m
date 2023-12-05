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
couplePropre = 1/2*polyval(p_psi_bb_der, alpha)*Ib;

coupleTot = coupleReluctant + coupleMutuel + couplePropre;

% couples en alpha = 0
startAngle = 5;
endAngle = 20;

Tem_aa = mean(coupleReluctant(startAngle:endAngle))*1e3
Tem_ba = mean(coupleMutuel(startAngle:endAngle))*1e3
Tem_bb = mean(couplePropre(startAngle:endAngle))*1e3

Tem = Tem_aa + Tem_ba + Tem_bb

% couple reluctant en butee
Tem_aa = coupleReluctant(end)*1e3;

%% permeances

la = 3e-3; % m
ib = 1; % A
Hc = 445e3; % A/m
nb = 1000; % -

lambda_aa = 2* WmagPrime/(Hc*la)^2;
lambda_bb = psi_bb/(nb^2*ib);
lambda_ab = psi_ba/(Hc*la*nb);

%% couple reluctant et total recalcule

alphaSym = -44:1:44;

Tem0 = getTem(0, p_W_der, p_psi_ba_der, p_psi_bb_der, alpha);
Tem1 = getTem(1, p_W_der, p_psi_ba_der, p_psi_bb_der, alpha);
Tem15 = getTem(1.5, p_W_der, p_psi_ba_der, p_psi_bb_der, alpha);

% symmetrical data left right
Tem0_flip = flipud(Tem0)
Tem0 = [Tem0_flip(1:end-1); Tem0]

Tem1_flip = flipud(Tem1)
Tem1 = [Tem1_flip(1:end-1); Tem1]

Tem15_flip = flipud(Tem15)
Tem15 = [Tem15_flip(1:end-1); Tem15]

%% plot results
% figure();
% plot(alpha, WmagPrime, 'bo'); hold on;
% plot(alpha, WmagPrime_model, 'b-');
% grid on;
% xlabel('\alpha [°]');
% ylabel('W''_{mag} [J]');
% 
% figure();
% plot(alpha, psi_bb, 'ro'); hold on;
% plot(alpha, psi_ba, 'bo');
% plot(alpha, psi_bb_model, 'r-');
% plot(alpha, psi_ba_model, 'b-');
% hold off;
% legend('\Psi_{bb}', '\Psi_{ba}', 'Location', 'southwest');
% grid on;
% xlabel('\alpha [°]');
% ylabel('Flux totalisés propres et mutuels [wb]');

% %% plot torques
% figure();
% plot(alpha, coupleReluctant, 'b-'); hold on;
% plot(alpha, coupleMutuel, 'r-');
% plot(alpha, couplePropre, 'g-');
% plot(alpha, coupleTot, 'm-');
% grid on;
% legend('Couple réluctant', 'Couple mutuel', 'Couple propre', 'Couple total','Location', 'southwest');
% xlabel('\alpha [°]');
% ylabel('Couple [Nm]');

%% plot permeances
% figure();
% plot(alpha, lambda_aa, 'bo'); hold on;
% plot(alpha, lambda_ab, 'ro');
% plot(alpha, lambda_bb, 'go');
% grid on;
% legend('Perméance réluctante', 'Perméance mutuelle', 'Perméance propre bobine', 'Location', 'southwest');
% xlabel('\alpha [°]');
% ylabel('Perméance [H]');

%% plot couple
figure();
plot(alphaSym, Tem0, 'b-'); hold on;
plot(alphaSym, Tem1, 'm-');
plot(alphaSym, Tem15, 'c-');
grid on;
legend('i_b = 0A', 'i_b = 1A', 'i_b = 1.5A', 'Location', 'northwest');
xlabel('\alpha [°]');
ylabel('Couple [Nm]');

function Tem = getTem(ib, p_W_der, p_psi_ba_der, p_psi_bb_der, alpha)
    WmagPrime_der = polyval(p_W_der, alpha);
    psi_ba_der = polyval(p_psi_ba_der, alpha);
    psi_bb_der = polyval(p_psi_bb_der, alpha);
    
    Tem = 1/2*psi_bb_der*ib + WmagPrime_der + psi_ba_der*ib; 
end
