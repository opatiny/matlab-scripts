%% Lois de Fresnel: Determination de l'indice d'une lame parralele
clc; clear; close all;

%% load data

data = readtable('./data.csv');

alpha = deg2rad(data.alpha)
eclairementS = data.eclairementS;
eclairementP = data.eclairementP;

theta_i = alpha/2;

%% minimisation fonction
ni = 1; % air

theta_t_fun = @(nt) asin(ni/nt*sin(theta_i));
Rs_fun = @(nt)(tan(theta_i-theta_t_fun(nt))./tan(theta_i+theta_t_fun(nt))).^2;
Rp_fun = @(nt)(sin(theta_i-theta_t_fun(nt))./sin(theta_i+theta_t_fun(nt))).^2;

% params contains [factor, nt]
errorFun = @(params) rms(params(1) * Rs_fun(params(2)) - eclairementS) + rms(params(1) * Rp_fun(params(2)) - eclairementP);

% approximate parameters
nt = 1.7; % [-]
factor = 15; % [lux]
approximateParams = [factor, nt];

eclairementP_approx = factor*Rp_fun(nt);
eclairementS_approx = factor*Rs_fun(nt);

% compute best fit

params = fminsearch(errorFun,approximateParams)
% optimising sum of both: [13.28, 1.74]
% optimising only S: [16.03, 1.64]
factor = params(1);
nt = params(2);

% model when optimising S+P
eclairementP_th = factor*Rp_fun(nt);
eclairementS_th = factor*Rs_fun(nt);

% model when optimising only S
factor_S_only = 16.03;
nt_S_only = 1.64;

eclairementP_th_S_only = factor_S_only*Rp_fun(nt_S_only);
eclairementS_th_S_only = factor_S_only*Rs_fun(nt_S_only);

%% find Brewster angle

approximateAngle = deg2rad(55); % °

ni = 1;
nt = 1.74; % for S+P and 1.64 for S only

theta_t_fun = @(theta_i) asin(ni/nt*sin(theta_i));
Rs_fun = @(theta_i)(tan(theta_i-theta_t_fun(theta_i))./tan(theta_i+theta_t_fun(theta_i))).^2;

brewterAngle = rad2deg(fminsearch(Rs_fun, approximateAngle)) % S+P: 60.1°, S: 58.6°


rad2deg(atan(1.74))
rad2deg(atan(1.64))
%% plot
theta_i = rad2deg(theta_i);
figure();
plot(theta_i, eclairementS, '.'); hold on;
plot(theta_i, eclairementS_th);
plot(theta_i, eclairementS_th_S_only);
plot(theta_i, eclairementP, '.');
plot(theta_i, eclairementP_th);
plot(theta_i, eclairementP_th_S_only);
hold off;
grid on;
xlabel('\theta_i [°]');
ylabel('\epsilon [lux]');
legend('Onde S','Modèle onde S (opti. S+P)', 'Modèle onde S (opti. S)', 'Onde P',  'Modèle onde P (opti. S+P)',...
    'Modèle onde P (opti. S)', 'Location', 'northwest');
