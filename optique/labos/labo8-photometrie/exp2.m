%% Verification de l'eclairement d'une source hors axe
clc; clear; close all;

%% load data
data = readtable('data_exp2.csv'); % [mm]
x = data.x; % [m]
eclairement = data.epsilon; % [lux]
h = 0.405; % [m]
h0 = 0.0112; % [m] -> deduit de l'exp 1

%% Correct data
theta = atan(x/(h+h0));

% modele source ponctuelle
sourcePonctuelleFun = @(I0) I0.*cos(theta).^3/(h+h0)^2;

I0 = eclairement(1) * (h + h0)^2; % 24.1 cd -> premiere approximation

eclairement_ponctuel = I0.*cos(theta).^3/(h+h0)^2;

diff = eclairement - eclairement_ponctuel;

theta_th = linspace(-1,1,1000);
eclairement_th_ponctuel = I0.*cos(theta_th).^3/(h+h0)^2;

%% calcul fonction gaussienne de correction
gaussianFun = @(k) exp(-k*theta.^2);

errorFun = @(params) rms(gaussianFun(params(1)).*sourcePonctuelleFun(params(2)) + params(3) - eclairement);

% approximate variables value
approximateParams = [1, 25, 5]; % k: 1/rad^2, I0: cd, offset: [lux]

% compute optimal values
params = fminsearch(errorFun,approximateParams)

k = params(1); % rad^-2
I0 = params(2); % cd
offset = params(3); % lux

% erreur avec offset: lux
error = errorFun(params)
% evaluate spread source model
eclairement_th_etendu = exp(-k*theta_th.^2).*I0.*cos(theta_th).^3/(h+h0)^2 + offset;

% sans l'offset -> comme demande dans le cours
errorFun = @(params) rms(gaussianFun(params(1)).*sourcePonctuelleFun(params(2)) - eclairement);
% approximate variables value
approximateParams = [1, 25]; % k: 1/rad^2, I0: cd, offset: [lux]

% compute optimal values
params = fminsearch(errorFun,approximateParams)

k_no = params(1); % rad^-2
I0_no = params(2); % cd

% erreur avec offset: lux
errorNoOffset = errorFun(params)
% evaluate spread source model
eclairement_th_noOffset = exp(-k_no*theta_th.^2).*I0_no.*cos(theta_th).^3/(h+h0)^2;

% find theta50: the angle for which epsilon is half the maximum
eclairement_max = max(eclairement_th_etendu);
eclairement50 = eclairement_max/2;
indices = find(eclairement_th_etendu>eclairement50);
theta50 = theta_th(indices(1)); % rad
rad2deg(theta50) % °

%% plot
figure();
plot(theta, eclairement, '.'); hold on;
plot(theta_th, eclairement_th_ponctuel);
hold off;
xlabel('angle [rad]');
ylabel('\epsilon [lux]');
legend({'Mesures', ['Modèle source ponctuelle:' newline 'I_0 = 24.1 cd']}, 'Location', 'northeast')
grid on;

figure();
plot(theta, eclairement, '.');hold on;
plot(theta_th, eclairement_th_noOffset);
plot(theta_th, eclairement_th_etendu);
plot([theta50, theta50], [0,160], 'g');
plot([-theta50, -theta50], [0,160], 'g');
hold off;
xlabel('angle [rad]');
ylabel('\epsilon [lux]');
legend({'Mesures', ['Modèle sans offset:' newline 'k = ' num2str(k_no, 2) ' rad^{-2}, I_0 =  ' num2str(I0_no, 2) ' cd'], ['Modèle avec offset:' newline 'k = ' num2str(k, 2) ' rad^{-2}' newline 'I_0 = ' num2str(I0, 2) ' cd' newline 'C = ' num2str(offset, 2) ' lux'], 'Angle auquel I = I_0/2'}, 'Location', 'northeast')
grid on;