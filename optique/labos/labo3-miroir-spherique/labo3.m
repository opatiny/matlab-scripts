%% Verify geometric optics laws for spherical mirror
clc; clear; close all;

%% Data and variables
data = readtable('labo3-data.csv'); % [mm]
hi = -data.hi;
xi = data.xi;
xo = data.xo;
ho = 13; % [mm]

%% Correct data
Gt_mes = hi/ho;

fun = @(deltas) rms(-(xi + deltas(1))./(xo + deltas(2)) - Gt_mes);
% approximate systematic errors value
approximateDeltas = [100, 90];
% compute optimal values
deltas = fminsearch(fun,approximateDeltas)

delta_i = deltas(1);
delta_o = deltas(2);

Gt_th = - (xi + delta_i)./(xo + delta_o);

% rms for the best fit
error = fun(deltas); % 0.0515

% compute linear fit
p = polyfit(Gt_th, Gt_mes, 1)
linModel = polyval(p, Gt_th);

%% plot
figure();
plot(Gt_th, Gt_mes, '.'); hold on;
plot(Gt_th, linModel);
plot(Gt_th, -xi./xo, '.');
hold off;
xlabel('-(x_i + \Delta_i)/(x_o + \Delta_o) [-]');
ylabel('h_i/h_o [-]');
legend('Grandissement corrigé: \Delta_i = 120.2, \Delta_o = 90.3', 'Régression linéaire: x = 0.9999y-0.0005', 'Données non corrigées', 'Location', 'southeast')
grid on;


%% compute pi and po

pi_inverse = 1./(xi + delta_i);
po_inverse = 1./(xo + delta_o);

[p, S] = polyfit(po_inverse,pi_inverse, 1);
linModel = polyval(p, po_inverse);

% vergence of the mirror -> y intercept
[vergence, sigma] = polyval(p, 0, S) % V = 0.00989, sigma = 8.16e-5
focal = 1/vergence; % f = 101.1 mm
deltaF = sigma/vergence*focal * 3 % 3 écarts-types

%% plot pi po
figure();
plot(po_inverse, pi_inverse, '.'); hold on;
plot(po_inverse, linModel);
hold off;
xlabel('1/po [mm]');
ylabel('1/pi [mm]');
legend('Données', 'Régression linéaire: x = -1.0708y+0.0099')
grid on;